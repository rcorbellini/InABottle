
String? enumToString([Object? objectEnum]) =>
    objectEnum?.toString().split('.').last;

bool isEnum<T>(T data) {
  final split = data.toString().split('.');
  return split.length > 1 && split[0] == data.runtimeType.toString();
}