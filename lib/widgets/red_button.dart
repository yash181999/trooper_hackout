import 'package:flutter/material.dart';
import 'package:trooper_hackout/resources/color.dart';

class RedButton extends StatelessWidget {

  final dynamic btnTitle,btnColor , textColor;

  RedButton({this.btnTitle = "Get Started", this.btnColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
        color: btnColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          //background color of box
          BoxShadow(
            color: white,
            blurRadius: 5.0, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: Offset(
              0.0, // Move to right 10  horizontally
              3.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: Text(
        btnTitle,
        style: TextStyle(
          color: textColor,
          fontSize: 18,
        ),
      ),
    );
  }
}