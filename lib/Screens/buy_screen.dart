import 'package:flutter/material.dart';
import 'package:trooper_hackout/widgets/app_bar.dart';

class BuyScreen extends StatefulWidget {
  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: appbar(
       title: "Buy Agriculture Goods"
     ),
    );
  }
}
