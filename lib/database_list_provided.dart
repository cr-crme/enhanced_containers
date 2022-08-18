import 'exceptions.dart';
import 'list_provided.dart';

abstract class DatabaseListProvided<T> extends ListProvided<T> {
  /// Creates an empty [DatabaseListProvided].
  DatabaseListProvided() : super();

  /// You can't use this function with [ListFirebase], as it already saves its content in the cloud automagically.
  @override
  void deserialize(map) {
    throw const ShouldNotCall(
        'You should not use this function with a Database List Provided.');
  }
}
