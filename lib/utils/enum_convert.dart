String enumToString(Object object) => object.toString().split('.').last;

T enumFromString<T>(String key, List<T> values) => values
    .firstWhere((element) => key == enumToString(element), orElse: () => null);
