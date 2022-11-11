import 'package:enhanced_containers/enhanced_containers.dart';

import '../models/my_random_item.dart';

class MapOfMyRandomItem extends MapProvided<MyRandomItem> {
  /// This examples shows how ot implement a [MapProvided] of some [ItemSerializable].
  /// ([MyRandomItem] in the current case).
  /// 
  
  /// This is a necessary override to use [MapProvided] as the enhanced provider
  /// need to know how to deserialize the [ItemSerializable].
  ///
  /// Usually, the item knows how deserialize itself, so it is simply a matter
  /// of calling that constructor.
  ///
  @override
  MyRandomItem deserializeItem(data) => MyRandomItem.deserialize(data);
}
