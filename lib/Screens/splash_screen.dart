import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:trooper_hackout/database/auth.dart';
import 'package:trooper_hackout/resources/color.dart';

import 'login.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserId();

    Future.delayed(
      Duration(seconds: 3),
      () {
        if (userId != null && userId.isNotEmpty) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ));
        }
        // else if(onBoarding == false && loggedIn == false) {
        //   Navigator.pushReplacement(context,MaterialPageRoute(
        //     builder: (context) => OnBoarding(),
        //   ));
        // }
        else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
        }
      },
    );
    Timer(Duration(seconds: 10), () {
      print("Yeah, this line is printed after 3 seconds");
    });
  }

  String userId;

  getUserId() async {
    await AuthService.getUserIdSharedPref().then((value) {
      setState(() {
        userId = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 170.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Krishak',
                style: TextStyle(
                  fontFamily: 'sf_pro_semibold',
                  fontSize: 40,
                  color: black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'किसान की उन्नति है, देश की प्रगति',
                style: TextStyle(
                  fontSize: 20,
                  color: const Color(0xff1b262c),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              JumpingDotsProgressIndicator(
                fontSize: 50.0,
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    height: 170,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/lowerd@3x.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
