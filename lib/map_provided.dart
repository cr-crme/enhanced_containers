import 'package:enhanced_containers_foundation/item_serializable.dart';
import 'package:enhanced_containers_foundation/map_serializable.dart';
import 'package:flutter/foundation.dart';

/// An iterable [Map] that implements [ChangeNotifier] to notify every modifications made to its content.
///
/// Written by: @pariterre and @Guibi1
abstract class MapProvided<T extends ItemSerializable>
    extends MapSerializable<T> with ChangeNotifier {
  /// Creates an empty [MapProvided].
  MapProvided();

  /// Creates a [MapProvided] from a map of serialized items.
  MapProvided.fromSerialized(super.map) : super.fromSerialized();

  /// Adds [item] to the map, extending the length by one.
  ///
  /// This method accepts a [String] as a [key] or an [ItemSerializable], where its id is going to be used.
  @override
  void add(T item, {String? key, bool notify = true}) {
    super.add(item, key: key);
    if (notify) notifyListeners();
  }

  /// Updates the value of [item].
  ///
  /// This only works when the ids of the new and old value are identical.
  @override
  void replace(T item, {String? key, bool notify = true}) {
    super.replace(item, key: key);
    if (notify) notifyListeners();
  }

  /// Sets the value of the item to [item] at the specified location.
  ///
  /// This method accepts a [String] as a [key] or an [ItemSerializable], where its id is going to be used.
  @override
  void operator []=(key, T item) {
    super[key] = item;
    notifyListeners();
  }

  /// Removes a single item from the list.
  ///
  /// This method accepts a [String] as a [value] or an [ItemSerializable], where its id is going to be used.
  @override
  void remove(value, {bool notify = true}) {
    super.remove(value);
    if (notify) notifyListeners();
  }

  /// Removes all objects from this map; the length of the map becomes zero.
  @override
  void clear({bool notify = true}) {
    super.clear();
    if (notify) notifyListeners();
  }

  /// If for some reason one needs to call notifier, they can call [forceNotify]
  void forceNotify() => notifyListeners();
}
