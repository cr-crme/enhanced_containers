import 'package:enhanced_containers/enhanced_containers.dart';

import '../models/my_random_item.dart';

class FirebaseListOfMyRandomItem extends FirebaseListProvided<MyRandomItem> {
  /// This examples shows how ot implement a [FirebaseListProvided] of some 
  /// [ItemSerializable] ([MyRandomItem] in the current case).
  /// Important note: The [FirebaseListProvided] assumes that the connexion 
  /// with Firebase is already established. 
  /// 
  
  /// This constructor is necessary as [pathToData] must be declared. 
  /// [pathToData] is the path in the data are store in the database. 
  /// Optionally, one can define the [pathToAvailableDataIds]. By default, 
  /// the [pathToAvailableDataIds] is the [pathToData] with 'ids' appended. 
  /// AvailableIds are a way to ensure one does not see the data from another
  /// user. For instance, if person1 adds data in [MyRandomItem] and person2 adds
  /// data as well, all the data are stored in [pathToData] but only what is 
  /// marked as available in [pathToAvailableDataIds] will be shown to person1 
  /// and person2 respectively.
  FirebaseListOfMyRandomItem({required super.pathToData});


  /// This is a necessary override to use [FirebaseListProvided] as the enhanced provider
  /// need to know how to deserialize the [ItemSerializable].
  ///
  /// Usually, the item knows how deserialize itself, so it is simply a matter
  /// of calling that constructor.
  ///
  @override
  MyRandomItem deserializeItem(data) => MyRandomItem.deserialize(data);
}
