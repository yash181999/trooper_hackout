import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trooper_hackout/database/auth.dart';
import 'package:trooper_hackout/resources/color.dart';
import 'package:trooper_hackout/video_call/pages/index.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  String userId  = '';

  getUserId() async{
    await AuthService.getUserIdSharedPref().then((value) {
        setState(() {
          userId = value;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: white,
        ),
        title: Text(
          "Notifications",
           style: TextStyle(
             color: white,
           ),
        ),
      ),


      body:Container(
        
        padding: EdgeInsets.all(10),
        
        child: StreamBuilder(

         stream: Firestore.instance.collection("VideoCall")
         .where("status",isEqualTo: "online").where("receiverId", isEqualTo: userId)
             .snapshots(),

         builder: (context,snapshot) {
           return snapshot.hasData  ? ListView.builder(

             itemCount: snapshot.data.documents.length,


             itemBuilder: (context, index) {
               DocumentSnapshot doc = snapshot.data.documents[index];

               return Column(
                 children: [
                   ListTile(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(

                        builder: (context) => IndexPage(
                         userId :   doc['callerId'],
                         userName: doc['callerName'],

                        )

                       ));
                     },
                      trailing: Icon(
                        Icons.video_call,
                        color: white,
                      ),
                     tileColor: secondary,
                     title: Text(
                         doc['callerName'],
                         style: TextStyle(
                           color: white,
                         ),
                     ),
                   ),

                   SizedBox(height: 10,),
                 ],
               );
             }


           ) : Container();
         }
        ),
      ),


    );
  }
}
