import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trooper_hackout/database/auth.dart';
import 'package:trooper_hackout/resources/color.dart';


class MyRequests extends StatefulWidget {
  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }
  String userId = "";
  getUserId() {
    AuthService.getUserIdSharedPref().then((value) {
      setState(() {
        userId = value;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: Firestore.instance.collection("Requests").where("sendByUserId", isEqualTo: userId).snapshots(),
            builder: (context, snapshot) {
              return snapshot.hasData ?  ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = snapshot.data.documents[index];
                    return Container(
                      height: 150,
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding:EdgeInsets.all(3) ,
                                    decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                    ),
                                    child: Text(
                                      doc['bloodGroup'],
                                      style: TextStyle(
                                        color: white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5,),

                                  Container(
                                    child: Text(
                                      doc['namePatient'],
                                      style: TextStyle(
                                          fontFamily: 'sf_pro_bold',
                                          fontSize: 18
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                              SizedBox(height: 8,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Date"),
                                  Text("Time"),
                                  Text("Location")
                                ],
                              ),

                              SizedBox(height: 4,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Text(doc['date']),
                                  Text(doc['time']),
                                  Text(doc['location']),
                                ],

                              ),

                              SizedBox(height: 20,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [



                                  Text(
                                      "Status : ",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),

                                  Text(
                                    doc['status'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: secondary,
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              ) :Center(
                child: Container(
                  child: Text("NO Requests FOUND"),
                ),
              );
            }
        )
    );
  }
}
