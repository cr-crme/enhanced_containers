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
    final out = serializedMap();
    out['id'] = id;
    return out;
  }

  /// The global id of each instances.
  final String id;
}
