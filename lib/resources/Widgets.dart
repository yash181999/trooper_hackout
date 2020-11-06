import 'package:flutter/material.dart';
import 'package:trooper_hackout/resources/color.dart';

Widget appbar ({String title }) {
  return AppBar(
    backgroundColor: primary,
       leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.black,),
         ),
       title: Center(
           child: Text(
           "$title",
             style: TextStyle(
               color: Colors.black
             ),
          ),
        ),
       actions: [
          Icon(Icons.notifications , color: Colors.black,),
          SizedBox(width: 15,)
        ],
        elevation: 0.0,
     );
}