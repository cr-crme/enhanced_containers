import 'exceptions.dart';
import 'item_serializable.dart';
import 'item_serializable_with_creation_time.dart';

/// An iterable [List] that is made to handle [ItemSerializable].
///
/// It allows to serialize and deserialize the whole list easily with [serialize]
/// and [ListSerializable.fromSerialized].
///
/// Written by: @pariterre and @Guibi1
abstract class ListSerializable<T extends ItemSerializable>
    extends Iterable<T> {
  /// Creates an empty [ListSerializable].
  ListSerializable();

  /// Creates a [ListSerializable] from a map of serialized items.
  ListSerializable.fromSerialized(map) {
    deserialize(map);
  }

  /// Serializes all of its items into a single map, separted by their id.
  Map<String, dynamic> serialize() {
    final serializedItem = <String, dynamic>{};
    for (final element in _items) {
      serializedItem[element.id] = element.serialize();
    }
    return serializedItem;
  }

  /// Returns a new [T] from the provided serialized data.
  T deserializeItem(data);

  /// Returns a copy of the raw list. This method must be used with great care
  /// since modifying this list can resulted in an ill-state of the [ListSerializable]
  Iterable<T> get rawList => _items;

  /// Deserializes a map of items with the help of [deserializeItem].
  void deserialize(map) {
    _items.clear();
    for (var element in map.values) {
      _items.add(deserializeItem(element));
    }
  }

  /// Adds [item] to the end of this list, extending the length by one.
  void add(T item) {
    _items.add(item);
  }

  /// Updates the value of [item].
  ///
  /// This only works when the ids of the new and old value are identical.
  void replace(T item) {
    _items[_getIndex(item)] = item;
  }

  @override
  bool contains(Object? element) {
    if (element is String) {
      return _items.any((item) => item.id == element);
    } else {
      return _items.contains(element);
    }
  }

  /// Sets the value of the item to [item] at the specified location.
  ///
  /// This method accepts an `int` as an index, an `String` as an id,
  /// and an [ItemSerializable] as the item to remove.
  operator []=(value, T item) {
    _items[_getIndex(value)] = item;
  }

  /// Returns the item at the location specified by [value].
  ///
  /// This method accepts an `int` as an index, an `String` as an id,
  /// and an [ItemSerializable] as the item to remove.
  T operator [](value) {
    return _items[_getIndex(value)];
  }

  /// Removes a single item from the list.
  ///
  /// This method accepts an `int` as an index, an `String` as an id,
  /// and an [ItemSerializable] as the item to remove.
  void remove(value) {
    _items.removeAt(_getIndex(value));
  }

  /// Moves an item from one position to another
  ///
  /// This method accepts two `int` as indices, to move a [ItemSerializable] from
  /// one place to another
  void move(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final item = _items.removeAt(oldIndex);
    _items.insert(newIndex, item);
  }

  /// Removes all objects from this list; the length of the list becomes zero.
  void clear() {
    _items.clear();
  }

  /// The first index in the list that satisfies the provided [test].
  ///
  /// Searches the list from index [start] to the end of the list.
  /// The first time an object `o` is encountered so that `test(o)` is true,
  /// the index of `o` is returned.
  int indexWhere(bool Function(T element) test, [int start = 0]) {
    return _items.indexWhere(test, start);
  }

  /// Return the element with specified [id].
  ///
  T fromId(String id) {
    return firstWhere((element) => element.id == id);
  }

  /// Returns the index of [value] using different methods depending of its type.
  int _getIndex(value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return _items.indexWhere((element) => element.id == value);
    } else if (value is ItemSerializable) {
      return _getIndex(value.id);
    } else {
      throw const TypeException(
        'Wrong type for getting an element of the list.',
      );
    }
  }

  /// This is a simple interface to the [map] method of the list
  @override
  Iterable<U> map<U>(toElement) {
    return _items.map(toElement);
  }

  Iterable<U> mapRemoveNull<U>(toElement) {
    return _items.map(toElement).where((e) => e != null).cast<U>();
  }

  final List<T> _items = [];

  @override
  Iterator<T> get iterator => _items.iterator;
}

/// Provides convenient functions if the list is time dependent, that is
/// made from [ItemSerializableWithCreationTime] items.
mixin ItemsWithCreationTimed<T extends ItemSerializableWithCreationTime>
    on ListSerializable<T> {
  /// Returns a sorted list reorder by time from the oldest to the earliest.
  ///
  /// The order is reversed if [reversed] is true.
  List<T> toListByTime({reversed = false}) {
    final orderedMessages = toList(growable: false);
    orderedMessages.sort(
      reversed
          ? (first, second) {
              return first.creationTimeStamp - second.creationTimeStamp;
            }
          : (first, second) {
              return second.creationTimeStamp - first.creationTimeStamp;
            },
    );
    return orderedMessages;
  }
}
