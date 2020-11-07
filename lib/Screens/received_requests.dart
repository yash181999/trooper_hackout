import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trooper_hackout/database/auth.dart';
import 'package:trooper_hackout/resources/color.dart';
import 'package:trooper_hackout/widgets/customButton.dart';
import 'package:trooper_hackout/widgets/custom_text.dart';


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
     await Firestore.instance.collection("Requests").document(docId).updateData({
       "status"  : "accepted",
     });
  }

  rejectRequest({dynamic docId}) async{
    await Firestore.instance.collection("Requests").document(docId).updateData({
      "status"  : "rejected",
    });
  }

  //listcard widget
  Widget ListCard({dynamic commodityName,
    dynamic sellerName, dynamic price,
    dynamic quantity, dynamic location,
    dynamic btnOnClick}){
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
                      text : commodityName,
                    )
                  ],
                ),

                SizedBox(height: 3,),

                Row(
                  children: [
                    CustomText(
                      fontFamily: 'sf_pro_bold',
                      text: "Seller Name : ",
                      fontSize: 14.0,
                    ),
                    CustomText(
                      fontFamily: 'sf_pro_regular',
                      text : sellerName,
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
                          text : location,
                          fontSize: 14.0,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 3,),

                CustomButton(
                  label: "View",
                  onPressed: (){
                    btnOnClick();
                  },
                  color: secondary,
                  labelColor: white,
                )

              ],
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
            stream: Firestore.instance.collection("Buy").where("senderId", isEqualTo: userId).snapshots(),
            builder: (context, snapshot) {
              return snapshot.hasData ?  ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = snapshot.data.documents[index];
                    return Container(
                      height: 150,
                      child: ListCard(

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
