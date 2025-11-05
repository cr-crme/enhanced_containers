import 'package:enhanced_containers/enhanced_containers.dart';

class MyRandomItem extends ItemSerializable {
  MyRandomItem({required this.title, required this.value});
  final String title;
  final double value;
  @override
  String toString() {
    return value.toString();
  }

  /// [serializedMap] is necessary as ItemSerializable should know how to
  /// serialize itself. It is common to also provide a [deserialize] constructor
  @override
  Map<String, dynamic> serializedMap() {
    return {'title': title, 'value': value};
  }

  /// Userfull constructor that constructs the Item from the same map as
  /// constructed by [serializedMap]
  static MyRandomItem deserialize(Map? data) {
    return MyRandomItem(
        title: data?['title'] ?? 'Not named', value: data?['value'] ?? 0);
  }
}
