import 'package:enhanced_containers_foundation/item_serializable.dart';

/// The base class for the timable items contained in all the custom containers.
///
/// Written by: @pariterre and @Guibi1
abstract class ItemSerializableWithCreationTime extends ItemSerializable {
  /// Creates an [ItemSerializableWithCreationTime] with the original [creationTimeStamp].
  ItemSerializableWithCreationTime({
    super.id,
    int? creationTimeStamp,
  }) : creationTimeStamp =
            creationTimeStamp ?? DateTime.now().microsecondsSinceEpoch;

  /// Creates an [ItemSerializableWithCreationTime] from a map of serialized items.
  ItemSerializableWithCreationTime.fromSerialized(super.map)
      : creationTimeStamp =
            map['creationTimeStamp'] ?? DateTime.now().microsecondsSinceEpoch,
        super.fromSerialized();

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
