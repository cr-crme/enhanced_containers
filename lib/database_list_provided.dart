import 'exceptions.dart';
import 'list_provided.dart';

abstract class DatabaseListProvided<T> extends ListProvided<T> {
  /// Creates an empty [DatabaseListProvided].
  DatabaseListProvided({
    required this.pathToData,
    String? pathToAvailableDataIds,
  }) : _pathToAvailableDataIds = pathToAvailableDataIds ?? '$pathToData-ids';

  /// You can't use this function with [ListFirebase], as it already saves its content in the cloud automagically.
  @override
  void deserialize(map) {
    throw const ShouldNotCall(
        'You should not use this function with a Database List Provided.');
  }

  /// The path to the stored data inside the database.
  final String pathToData;

  /// The path to the list of available ids inside the database.
  String _pathToAvailableDataIds;
  // ignore: unnecessary_getters_setters
  String get pathToAvailableDataIds => _pathToAvailableDataIds;
  set pathToAvailableDataIds(String newPath) {
    _pathToAvailableDataIds = newPath;
  }
}
