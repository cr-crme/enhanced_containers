import './item_serializable.dart';

/// The base class for the timable items contained in all the custom containers.
///
/// Written by: @pariterre and @Guibi1
abstract class CreationTimeItemSerializable extends ItemSerializable {
  /// Creates an [CreationTimeItemSerializable] with the original [creationTimeStamp].
  CreationTimeItemSerializable({String? id, int? creationTimeStamp})
      : creationTimeStamp =
            creationTimeStamp ?? DateTime.now().microsecondsSinceEpoch,
        super(id: id);

  /// Creates an [CreationTimeItemSerializable] from a map of serialized items.
  CreationTimeItemSerializable.fromSerialized(map)
      : creationTimeStamp =
            map['creationTimeStamp'] ?? DateTime.now().microsecondsSinceEpoch,
        super.fromSerialized(map);

  /// Serializes the current object.
  @override
  // ignore: invalid_override_of_non_virtual_member
  Map<String, dynamic> serialize() {
    var out = super.serialize();
    out['creationTimeStamp'] = creationTimeStamp;
    return out;
  }

  /// The global creation time stamp of each instances.
  final int creationTimeStamp;
}
