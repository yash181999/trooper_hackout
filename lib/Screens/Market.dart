import 'package:flutter/material.dart';
import 'package:trooper_hackout/Screens/NavDrawer.dart';
import 'package:trooper_hackout/widgets/Market_card.dart';
import 'package:trooper_hackout/widgets/app_bar.dart';

class Market extends StatefulWidget {
  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: appbar(
         title: "Market Price"
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 30),
          child: Column(
            children: [
              MarketCard(CropName: "Corn", CurrentPrice: "3000",),

              SizedBox(height: 20,),

              MarketCard(CropName: "Wheat", CurrentPrice: "2000", arrow: "up",),


              SizedBox(height: 20,),

              MarketCard(CropName: "Wheat", CurrentPrice: "2000", arrow: "up",),


              SizedBox(height: 20,),

              MarketCard(CropName: "Soyabeen", CurrentPrice: "1500", arrow: "up",),


              SizedBox(height: 20,),

              MarketCard(CropName: "Potato", CurrentPrice: "200",),

              SizedBox(height: 20,),

              MarketCard(CropName: "Tomato", CurrentPrice: "150", arrow: "up",),

              SizedBox(height: 20,),

              MarketCard(CropName: "Cotton", CurrentPrice: "1700",),

            ],
          ),
        ),
      ),
    );
  }
}
