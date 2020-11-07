import 'package:flutter/material.dart';
import 'package:trooper_hackout/resources/color.dart';

Widget appbar ({String title , dynamic widget,dynamic onPressed}) {
  return AppBar(

    backgroundColor: primary,
       iconTheme: IconThemeData(
         color: Colors.white,
       ),
       leading: widget,
       title: Center(
           child: Text(
           "$title",
             style: TextStyle(
               color: Colors.white
             ),
          ),
        ),
       actions: [
          IconButton(
            onPressed: (){
              onPressed();
            },
            icon : Icon(Icons.notifications) ,
            color: Colors.white,
          ),
          SizedBox(width: 15,)
        ],
        elevation: 0.0,
     );
}