import 'package:flutter/foundation.dart';
import 'package:nanoid/nanoid.dart';

/// The base class for the items contained in all the custom containers.
///
/// Written by: @pariterre and @Guibi1
abstract class ItemSerializable {
  /// Creates an [ItemSerializable] with the provided [id], or a randomly generated one.
  ItemSerializable({String? id}) : id = id ?? nanoid();

  /// Creates an [ItemSerializable] from a map of serialized items.
  ItemSerializable.fromSerialized(map)
      : id = map != null && map['id'] != null ? map['id'] : nanoid();

  /// Must be overriten to serialise additionnal information.
  Map<String, dynamic> serializedMap();

  /// Serializes the current object.
  @nonVirtual
  Map<String, dynamic> serialize() {
    var out = serializedMap();
    out['id'] = id;
    return out;
  }

  /// The global id of each instances.
  final String id;

  /// Helpers to deserialize
  static List<String> listFromSerialized(List? list) {
    return (list ?? []).map((e) => e.toString()).toList();
  }

  static Set<String> setFromSerialized(List? list) {
    return (list ?? []).map((e) => e.toString()).toSet();
  }

  static Map<String, dynamic> mapFromSerialized(Map? map) {
    return (map ?? {}).map((k, v) => MapEntry(k.toString(), v));
  }

  static double doubleFromSerialized(num? number, {double defaultValue = 0}) {
    if (number is int) return number.toDouble();
    return (number ?? defaultValue) as double;
  }
}
