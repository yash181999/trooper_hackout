
import 'package:flutter/material.dart';
import 'package:trooper_hackout/database/auth.dart';

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
        if(userId != null && userId.isNotEmpty) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => MainScreen(),
          ));
        }
        // else if(onBoarding == false && loggedIn == false) {
        //   Navigator.pushReplacement(context,MaterialPageRoute(
        //     builder: (context) => OnBoarding(),
        //   ));
        // }
        else{
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
        }
      },
    );
  }

  String userId;

  getUserId() async{
    await AuthService.getUserIdSharedPref().then((value) {
      setState(() {
        userId = value;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
