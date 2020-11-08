import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trooper_hackout/database/auth.dart';
import 'package:trooper_hackout/resources/color.dart';
import 'package:trooper_hackout/widgets/customButton.dart';
import 'package:trooper_hackout/widgets/custom_text.dart';
import 'package:trooper_hackout/widgets/red_button.dart';


class ReceivedRequests extends StatefulWidget {
  @override
  _ReceivedRequestsState createState() => _ReceivedRequestsState();
}

class _ReceivedRequestsState extends State<ReceivedRequests> {

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

  acceptRequest({dynamic docId}) async{
     await Firestore.instance.collection("Buy").document(docId).updateData({
       "status"  : "accepted",
     });
  }

  rejectRequest({dynamic docId}) async{
    await Firestore.instance.collection("Buy").document(docId).updateData({
      "status"  : "rejected",
    });
  }

  //listcard widget
  Widget ListCard({dynamic itemName,
    dynamic buyerName, dynamic price,
    dynamic quantity, dynamic address,

    dynamic docId,dynamic phone, dynamic status}){
    return Column(
      children: [
        Card(
          child :  Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomText(
                      fontFamily: 'sf_pro_bold',
                      text: "Commodity : ",
                    ),
                    CustomText(
                      fontFamily: 'sf_pro_regular',
                      text : itemName,
                    )
                  ],
                ),

                SizedBox(height: 3,),

                Row(
                  children: [
                    CustomText(
                      fontFamily: 'sf_pro_bold',
                      text: "Buyer Name : ",
                      fontSize: 14.0,
                    ),
                    CustomText(
                      fontFamily: 'sf_pro_regular',
                      text : buyerName,
                      fontSize: 14.0,
                    )
                  ],
                ),

                SizedBox(height: 3,),

                Row(
                  children: [
                    CustomText(
                      fontFamily: 'sf_pro_bold',
                      text: "Price : ",
                      fontSize: 14.0,
                    ),
                    CustomText(
                      fontFamily: 'sf_pro_regular',
                      text : price,
                      fontSize: 14.0,
                    )
                  ],
                ),

                SizedBox(height: 3,),

                Row(
                  children: [
                    CustomText(
                      fontFamily: 'sf_pro_bold',
                      text: "Quantity : ",
                      fontSize: 14.0,
                    ),
                    CustomText(
                      fontFamily: 'sf_pro_regular',
                      text : quantity,
                      fontSize: 14.0,
                    )
                  ],
                ),
                SizedBox(height: 3,),

                Container(
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomText(
                          fontFamily: 'sf_pro_bold',
                          text: "Location : ",
                          fontSize: 14.0,
                        ),
                      ),
                      Flexible(
                        child: CustomText(
                          fontFamily: 'sf_pro_regular',
                          text : address,
                          fontSize: 14.0,
                        ),
                      )
                    ],
                  ),
                ),



                SizedBox(height: 3,),



                Container(
                  child: Row(

                    children: [
                      Flexible(
                        child: CustomText(
                          fontFamily: 'sf_pro_bold',
                          text: "Status : ",
                          fontSize: 14.0,
                        ),
                      ),
                      Flexible(
                        child: CustomText(
                          fontFamily: 'sf_pro_regular',
                          text : status,
                          fontSize: 14.0,
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 3,),


                if (status=='pending') Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){acceptRequest(docId: docId);},
                      child: RedButton(
                        btnTitle: "Accept",
                        btnColor: secondary,
                        textColor: white,
                      ),
                    ),

                    SizedBox(width: 50,),

                    InkWell(
                      onTap: (){acceptRequest(docId: docId);},
                      child: RedButton(
                        btnTitle: "Reject",
                        btnColor: Colors.redAccent,
                        textColor: white,
                      ),
                    ),
                  ],
                ) else if(status == 'rejected') Text("Rejected By You") else Text("Accepted by you"),]
            ),

          ),
        ),

        SizedBox(height: 20,)
      ],
    );
  }
  //listcard widget


  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
            stream: Firestore.instance.collection("Buy").where("sellerId", isEqualTo: userId).snapshots(),
            builder: (context, snapshot) {
              return snapshot.hasData ?  ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = snapshot.data.documents[index];
                    return Container(

                      child: ListCard(
                         buyerName: doc['buyerName'],
                         docId: doc.documentID,
                         address: doc['address'],
                         price: doc['price'],
                         status: doc['status'],
                         phone: doc['phone'],
                         quantity:  doc['quantity'],
                         itemName : doc['itemName'],
                      )
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
