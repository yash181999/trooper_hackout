import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  _openLanguage() {
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child:RaisedButton(
            onPressed: (){
              _openLanguage(context);
            },
            color: Colors.redAccent,
            child: Text("Language"),
          ),
        ),
      ),
    );
  }
}
