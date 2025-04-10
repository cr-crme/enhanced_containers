import 'package:enhanced_containers/list_provided.dart';
import 'package:enhanced_containers_foundation/exceptions.dart';
import 'package:enhanced_containers_foundation/item_serializable.dart';

abstract class DatabaseListProvided<T extends ItemSerializable>
    extends ListProvided<T> {
  /// Creates an empty [DatabaseListProvided].
  DatabaseListProvided();

  /// This method should be called after the user has logged in so they can
  /// start fetching data
  Future<void> initializeFetchingData();

  /// This method should be called after the user has logged out so they stop
  /// fetching data
  Future<void> stopFetchingData();

  /// You can't use this function with [DatabaseListProvided], as it already
  /// saves its content in the cloud automagically.
  @override
  void deserialize(map) {
    throw const ShouldNotCall(
        'You should not use this function with a Database List Provided.');
  }
}
