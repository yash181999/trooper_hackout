import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {

  final fontSize, fontFamily,text;
  CustomText({this.fontSize = 18.0 ,this.fontFamily,this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily
      ),
    );
  }
}
