import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_unity/flutter_unity.dart';
import 'package:flutter_unity_challenge/models/weather.dart';

class UnityViewPage extends StatefulWidget {
  final Weather weather;

  UnityViewPage({Key key, @required this.weather}) : super(key: key);

  @override
  _UnityViewPageState createState() => _UnityViewPageState();
}

class _UnityViewPageState extends State<UnityViewPage> {
  UnityViewController unityViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unity'),
      ),
      body: UnityView(
        onCreated: onUnityViewCreated,
      ),
    );
  }

  void onUnityViewCreated(UnityViewController controller) {
    unityViewController = controller;

    unityViewController.send('Manager', "Setup", jsonEncode(widget.weather.toJson()));
  }
}
