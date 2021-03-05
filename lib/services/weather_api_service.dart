import 'dart:convert';

import 'package:flutter_unity_challenge/models/weather.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherApiService {
  static WeatherApiService _apiService = WeatherApiService._();
  final String _apiKey = env['OPENWEATHERMAP_API_KEY'];
  final String _host = env['OPENWEATHERMAP_ENDPOINT'];

  WeatherApiService._();

  static WeatherApiService get api => _apiService;

  Future<Weather> fetchCurrentWeather(int cityID) async {
    final response = await http.get(Uri.https(_host, 'data/2.5/weather',
        {"id": cityID.toString(), "appid": _apiKey, "units": "metric"}));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to get weather from API');
    }
  }
}
