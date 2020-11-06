import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {

  final text;
  HeadingText(this.text);

  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'sf_pro_bold',
          fontSize: 28,
        ),
      ),
    );
  }
}
