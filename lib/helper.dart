import './timed_item_serializable.dart';
import 'list_serializable.dart';

/// Reorder by time
List<T> sortByCreationTime<T>(ListSerializable<TimedItemSerializable> myList) {
  final orderedMessages = myList.toList(growable: false);
  orderedMessages.sort((first, second) {
    return first.creationTimeStamp - second.creationTimeStamp;
  });
  return orderedMessages as List<T>;
}
