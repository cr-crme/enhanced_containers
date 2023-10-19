import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database_mocks/firebase_database_mocks.dart';

import 'database_list_provided.dart';
import 'exceptions.dart';
import 'item_serializable.dart';
import 'list_serializable.dart';

/// A [ListProvided] that automagically saves all of its into Firebase's Realtime Database, and notifies of changes made in real time.
///
/// Written by: @Guibi1
abstract class FirebaseListProvided<T extends ItemSerializable>
    extends DatabaseListProvided<T> {
  /// Creates a [FirebaseListProvided] with the specified data path and ids path.
  FirebaseListProvided(
      {required this.pathToData,
      String? pathToAvailableDataIds,
      this.mockMe = false})
      : _pathToAvailableDataIds = pathToAvailableDataIds ?? '$pathToData-ids';

  /// This method should be called after the user has logged on
  @override
  void initializeFetchingData() {
    if (pathToAvailableDataIds.isEmpty) return;

    if (!_isInitialized) _listenToDatabase();
    _isInitialized = true;
  }

  bool _isInitialized = false;
  final bool mockMe;

  void _listenToDatabase() {
    if (mockMe) return;

    // Listen to added ids
    _availableDataIdsAddedSubscription =
        _availableIdsRef.onChildAdded.listen((DatabaseEvent event) {
      String id = event.snapshot.key!;
      // Get the new element data
      _dataRef.child(id).get().then((data) {
        // Add it to the list and notify
        super.add(deserializeItem(data.value), notify: true);
      });

      // Listen to data changes
      _dataSubscriptions[id] =
          _dataRef.child(id).onChildChanged.listen((DatabaseEvent event) {
        // Serialize the current item and update the new value
        var map = this[id].serialize();
        map[event.snapshot.key!] = event.snapshot.value;

        // Replace the element in the list and notify
        super.replace(deserializeItem(map), notify: true);
      });
    });

    // Listen to removed ids
    _availableDataIdsRemovedSubscription =
        _availableIdsRef.onChildRemoved.listen((DatabaseEvent event) {
      // Stop listening to data changes
      _dataSubscriptions.remove(event.snapshot.key!)?.cancel();
      // Remove the enterprise from the list and notify
      super.remove(event.snapshot.key!, notify: true);
    });
  }

  void _sanityChecks({required bool isInitialized, required bool notify}) {
    assert(notify, 'Notify has no effect here and should not be used.');
    assert(
        _isInitialized, 'Please call \'initializeFetchingData\' at least once');
  }

  /// Adds an item to the Realtime Database.
  ///
  /// Note that [notify] has no effect here and should not be used.
  @override
  void add(T item, {bool notify = true}) {
    _sanityChecks(isInitialized: _isInitialized, notify: notify);

    _dataRef.child(item.id).set(item.serialize());
    _availableIdsRef.child(item.id).set(true);

    if (mockMe) {
      super.add(item, notify: true);
    }
  }

  /// Inserts elements in a list of a logged user
  ///
  void insertInList(String pathToItem, ListSerializable items) {
    for (final item in items) {
      _dataRef.child(pathToItem).child(item.id).set(item.serialize());
    }
  }

  /// Replaces the current item by [item] in the Realtime Database.
  /// The item to replace is identified by its id.
  ///
  /// Note that [notify] has no effect here and should not be used.
  @override
  void replace(T item, {bool notify = true}) {
    _sanityChecks(isInitialized: _isInitialized, notify: notify);

    _dataRef.child(item.id).set(item.serialize());
    if (mockMe) {
      super.replace(item, notify: true);
    }
  }

  /// You can't not use this function with [FirebaseListProvided] in case the ids of the provided values dont match.
  /// Use the function [replace] intead.
  @override
  operator []=(value, T item) {
    throw const ShouldNotCall(
        'You should not use this operator. Use the function replace instead.');
  }

  /// Removes an item from the Realtime Database.
  ///
  /// Note that [notify] has no effect here and should not be used.
  @override
  void remove(value, {bool notify = true}) {
    _sanityChecks(isInitialized: _isInitialized, notify: notify);

    _availableIdsRef.child(this[value].id).remove();
    _dataRef.child(this[value].id).remove();

    if (mockMe) {
      super.remove(value, notify: true);
    }
  }

  /// Removes all objects from this list and from the Realtime Database; the length of the list becomes zero.
  /// Setting [confirm] to true is required in order to call this function as a 'security' mesure.
  ///
  /// Note that [notify] has no effect here and should not be used.
  @override
  void clear({bool confirm = false, bool notify = true}) {
    _sanityChecks(isInitialized: _isInitialized, notify: notify);
    if (!confirm) {
      throw const ShouldNotCall(
          'You almost cleared the entire database ! Set the parameter confirm to true if that was really your intention.');
    }

    for (final item in this) {
      remove(item);
    }
  }

  /// The path to the stored data inside the database.
  final String pathToData;

  /// The path to the list of available ids inside the database.
  String _pathToAvailableDataIds;

  /// The path to the list of available ids inside the database.
  String get pathToAvailableDataIds => _pathToAvailableDataIds;

  /// This will cancel all database subscriptions, then clear all data, then listen to the new path of ids
  set pathToAvailableDataIds(String newPath) {
    if (_isInitialized) {
      _availableDataIdsAddedSubscription.cancel();
      _availableDataIdsRemovedSubscription.cancel();
      _dataSubscriptions.forEach((id, sub) => sub.cancel());
    }

    _pathToAvailableDataIds = newPath;
    _isInitialized = false;
    super.clear();
  }

  // The Firebase subscriptions
  late StreamSubscription<DatabaseEvent> _availableDataIdsAddedSubscription;
  late StreamSubscription<DatabaseEvent> _availableDataIdsRemovedSubscription;

  final Map<String, StreamSubscription<DatabaseEvent>> _dataSubscriptions = {};

  // Firebase Reference getters
  FirebaseDatabase get firebaseInstance =>
      mockMe ? MockFirebaseDatabase.instance : FirebaseDatabase.instance;

  DatabaseReference get _availableIdsRef =>
      firebaseInstance.ref(pathToAvailableDataIds);
  DatabaseReference get _dataRef => firebaseInstance.ref(pathToData);
}
