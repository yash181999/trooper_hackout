import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {

  final text , fontSize;
  HeadingText(this.text , {this.fontSize = 28});

  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'sf_pro_bold',
          fontSize: fontSize,
        ),
      ),
    );
  }
}
