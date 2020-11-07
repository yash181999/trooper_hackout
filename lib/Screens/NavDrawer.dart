import 'package:flutter/material.dart';
import 'package:trooper_hackout/Buy_sell.dart';
import 'package:trooper_hackout/Market.dart';
import 'package:trooper_hackout/Screens/WeatherScreen.dart';
import 'package:trooper_hackout/Screens/buy_screen.dart';
import 'package:trooper_hackout/Screens/tlight.dart';

class NavDrawer extends StatelessWidget {

  String Name , email;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  Text(
                    "My Profile",
                    style: TextStyle(
                        fontFamily: "sf_pro_medium",
                        fontSize: 23
                    ),
                  ),
                  SizedBox(height: 40,),
                  Row(
                    children: [
                      SizedBox(width: 30,),
                      Center(
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                "Vinay Solanki",
                                style: TextStyle(
                                    fontFamily: "sf_pro_medium",
                                    fontSize: 20
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Center(
                              child: Text(
                                "vinaysolanki535@gmail.com",
                                style: TextStyle(
                                    fontFamily: "sf_pro_medium",
                                    fontSize: 15
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.corporate_fare_sharp , color: Colors.black,),
            title: Text(
              'Market',
              style: TextStyle(
                  fontFamily: "sf_pro_medium",
                  color: Colors.black
              ),
            ),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Market()))
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user , color: Colors.black,),
            title: Text('Solution',style: TextStyle(fontFamily: "sf_pro_medium", color: Colors.black),),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => Tlight()))},
          ),
          ListTile(
            leading: Icon(Icons.videocam , color: Colors.black,),
            title: Text('Weather' , style: TextStyle(fontFamily: "sf_pro_medium", color: Colors.black),),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherScreen()))},
          ),
          ListTile(
            leading: Icon(Icons.message , color: Colors.black,),
            title: Text('BuySell' , style: TextStyle(fontFamily: "sf_pro_medium", color: Colors.black),),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => BuyScreen()))},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app , color: Colors.black,),
            title: Text('Logout',style: TextStyle(fontFamily: "sf_pro_medium", color: Colors.black),),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}