import 'package:flutter/material.dart';
import 'package:trooper_hackout/resources/Widgets.dart';

class SellScreen extends StatefulWidget {
  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: appbar(
        title: "Sell Agriculture Goods"
      ),
    );
  }
}
