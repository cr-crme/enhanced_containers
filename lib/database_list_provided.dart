import 'exceptions.dart';
import 'item_serializable.dart';
import 'list_provided.dart';

abstract class DatabaseListProvided<T extends ItemSerializable>
    extends ListProvided<T> {
  /// Creates an empty [DatabaseListProvided].
  DatabaseListProvided();

  /// This method should be called after the user has logged in so they can
  /// start fetching data
  void initializeFetchingData();

  /// You can't use this function with [DatabaseListProvided], as it already
  /// saves its content in the cloud automagically.
  @override
  void deserialize(map) {
    throw const ShouldNotCall(
        'You should not use this function with a Database List Provided.');
  }
}
