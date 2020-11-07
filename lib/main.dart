import 'package:flutter/material.dart';
import 'package:trooper_hackout/Screens/NewsScreen.dart';
import 'package:trooper_hackout/Screens/WeatherScreen.dart';
import 'package:trooper_hackout/resources/app_translations_delegate.dart';
import 'package:trooper_hackout/resources/application.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
