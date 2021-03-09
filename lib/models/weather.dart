import 'package:flutter_unity_challenge/utils/enum_convert.dart';

enum WeatherCondition{
  Thunderstorm,
  Drizzle,
  Rain,
  Snow,
  Atmosphere,
  Clear,
  Clouds
}

class Weather {
  int temperature;
  WeatherCondition weatherCondition;


  Weather({this.temperature, this.weatherCondition});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: (json['main']['temp'] as num).round(),
      weatherCondition: enumFromString(json['weather'][0]['main'], WeatherCondition.values) ,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'temperature': temperature,
        'weatherCondition': weatherCondition != null ? enumToString(weatherCondition) : null,
      };
}