import 'package:flutter/material.dart';
import 'package:trooper_hackout/Screens/WeatherScreen.dart';
import 'package:trooper_hackout/Screens/main_screen.dart';
import 'package:trooper_hackout/Screens/splash_screen.dart';
import 'package:trooper_hackout/Screens/tlight.dart';
import 'package:trooper_hackout/database/auth.dart';
import 'package:trooper_hackout/resources/app_translations_delegate.dart';
import 'package:trooper_hackout/resources/application.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:trooper_hackout/resources/color.dart';


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
  void initState() {
    // TODO: implement initState
    super.initState();


  }







  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor:primary,
        fontFamily: 'sf_pro_regular',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}
