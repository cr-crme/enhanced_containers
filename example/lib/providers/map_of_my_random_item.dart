import 'package:enhanced_containers/enhanced_containers.dart';

import '../models/my_random_item.dart';

class MapOfMyRandomItem extends MapProvided<MyRandomItem> {
  /// This is a necessary override as [MapProvided] maps [SerializableItems].
  /// Therefore, the program must know how to deserialize the actual item.
  ///
  /// Usually, the item would deserialize itself, so it is simply a matter
  /// of calling that constructor.
  ///
  @override
  MyRandomItem deserializeItem(data) => MyRandomItem.deserialize(data);
}
