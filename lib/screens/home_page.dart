import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_unity_challenge/models/city.dart';
import 'package:flutter_unity_challenge/models/weather.dart';
import 'package:flutter_unity_challenge/resources/constants.dart';
import 'package:flutter_unity_challenge/screens/unity_view_page.dart';
import 'package:flutter_unity_challenge/services/weather_api_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  String _timeString;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timeString = formatDate.format(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Unity Flutter Challenge"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _buildList()
    );
  }

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cities.length + 1,
        itemBuilder: (BuildContext _context, int index) {

          if (index != 0) {
            City currentCity = cities[index - 1];
            return _buildItem(
                titleText: currentCity.cityName,
                onTapFunc: () => _onCityTap(currentCity));
          }
          return _buildItem(titleText: _timeString);
        });
  }

  Widget _buildItem(
      {@required String titleText,
      String subtitleText,
      Function onTapFunc}) {
    return Column(children: [
      ListTile(
          title: Text(titleText),
          subtitle: subtitleText != null ? Text(subtitleText) : null,
          onTap: onTapFunc != null ? () => onTapFunc() : null),
      new Divider(height: 1.0)
    ]);
  }

  void _onCityTap(City selectedCity) async {
    Future<Weather> futureWeather;
    this._isLoading = true;
    futureWeather = WeatherApiService.api.fetchCurrentWeather(selectedCity.id);
    futureWeather
        .then((weather) {
          return Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UnityViewPage(weather: weather)));
        })
        .catchError((onError) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(onError.toString()),
                duration: const Duration(seconds: 2))))
        .whenComplete(() => this._isLoading = false);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = formatDate.format(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }
}
