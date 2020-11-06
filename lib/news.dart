import 'package:flutter/material.dart';
import 'package:trooper_hackout/resources/Widgets.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title: "News"),
    );
  }
}
