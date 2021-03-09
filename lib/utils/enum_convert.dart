import 'package:collection/collection.dart' show IterableExtension;

String enumToString(Object object) => object.toString().split('.').last;

T enumFromString<T>(String key, List<T> values) => values
    .firstWhereOrNull((element) => key == enumToString(element));
