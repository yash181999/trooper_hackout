import 'package:flutter/material.dart';
import 'package:trooper_hackout/resources/color.dart';


class MarketCard extends StatelessWidget {
  String CropName , CurrentPrice , arrow;
  MarketCard({this.CropName , this.CurrentPrice , this.arrow});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5 , vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primary,
          boxShadow: [new BoxShadow(
            color: Colors.black,
            blurRadius: 4,
          ),]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Crop Name",
                style: TextStyle(color: Colors.white , fontSize: 18),
              ),
              Text(
                "$CropName",
                style: TextStyle(
                    color: Colors.white
                ),
              )
            ],
          ),

          SizedBox(height: 5,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                  "Current Market Price",
                style: TextStyle(color: Colors.white , fontSize: 18),
              ),
              Text(
                  "$CurrentPrice",
                style: TextStyle(
                  color: Colors.white
                ),
              )
            ],
          ),

          SizedBox(height: 5,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Price Prediction",
                style: TextStyle(color: Colors.white , fontSize: 18),
              ),
              Icon(
                (arrow == "up") ? Icons.arrow_upward : Icons.arrow_downward , color: Colors.white
              )
            ],
          ),

        ],
      ),
    );
  }
}
