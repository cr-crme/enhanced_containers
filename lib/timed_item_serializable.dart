import './item_serializable.dart';

/// The base class for the timable items contained in all the custom containers.
///
/// Written by: @pariterre and @Guibi1
abstract class TimedItemSerializable extends ItemSerializable {
  /// Creates an [TimedItemSerializable] with the original [creationTimeStamp].
  TimedItemSerializable({String? id, int? creationTimeStamp})
      : creationTimeStamp =
            creationTimeStamp ?? DateTime.now().microsecondsSinceEpoch,
        super(id: id);

  /// Creates an [TimedItemSerializable] from a map of serialized items.
  TimedItemSerializable.fromSerialized(map)
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
