import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trooper_hackout/Market.dart';
import 'package:trooper_hackout/Screens/WeatherScreen.dart';
import 'package:trooper_hackout/Screens/buy_screen.dart';
import 'package:trooper_hackout/Screens/login.dart';
import 'package:trooper_hackout/Screens/tlight.dart';
import 'package:trooper_hackout/database/auth.dart';
import 'package:trooper_hackout/resources/color.dart';
import 'package:trooper_hackout/resources/color.dart';
import 'package:trooper_hackout/resources/color.dart';

class NavDrawer extends StatefulWidget {

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }
  String name, userId,address;
  getDetails() async{
    await AuthService.getUserNameSharePref().then((value) {
        setState(() {
          name = value;
        });
    });


     await AuthService.getUserNameSharePref().then((value) {
       setState(() {
         userId = value;
       });
     });

     await Firestore.instance.collection("Users").document(userId).get().then((value) {

        setState(() {
             address = value['district'] + value['state'];
        });

     });

  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: primary
            ),
            child: Container(
              color: primary,
              child: Column(

                children: [
                  Text(
                    "My Profile",
                    style: TextStyle(
                        fontFamily: "sf_pro_medium",
                        fontSize: 23,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(height: 40,),
                  Column(
                    children: [
                      SizedBox(width: 30,),
                      Center(
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                name,
                                style: TextStyle(
                                    fontFamily: "sf_pro_medium",
                                    fontSize: 20,
                                    color: Colors.white
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Center(
                              child: Text(
                                address != null ? address : "Dewas",
                                style: TextStyle(
                                    fontFamily: "sf_pro_medium",
                                    fontSize: 15,
                                    color: Colors.white
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
            onTap: () async{

                Navigator.pushReplacement(context, MaterialPageRoute(
                     builder: (context) => LoginScreen()
                ));

                await FirebaseAuth.instance.signOut();

              }

          ),
        ],
      ),
    );
  }
}