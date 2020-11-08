import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trooper_hackout/database/auth.dart';
import 'package:trooper_hackout/resources/color.dart';
import 'package:trooper_hackout/widgets/custom_text.dart';


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


  //listcard widget
  Widget ListCard({dynamic commodityName,dynamic status, dynamic commodityPrice, dynamic myPrice, dynamic sellerName, dynamic myQuantity, dynamic quantity}){
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
                      text: "Commodity Price : ",
                      fontSize: 14.0,
                    ),
                    CustomText(
                      fontFamily: 'sf_pro_regular',
                      text : commodityPrice,
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


                Row(
                  children: [
                    CustomText(
                      fontFamily: 'sf_pro_bold',
                      text: "My Price : ",
                      fontSize: 14.0,
                    ),
                    CustomText(
                      fontFamily: 'sf_pro_regular',
                      text : myPrice,
                      fontSize: 14.0,
                    )
                  ],
                ),


                SizedBox(height: 3,),


                Row(
                  children: [
                    CustomText(
                      fontFamily: 'sf_pro_bold',
                      text: "Seller Name: ",
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
    return Scaffold(
        body: StreamBuilder(
            stream: Firestore.instance.collection("Buy").where("buyerId", isEqualTo: userId).snapshots(),
            builder: (context, snapshot) {
              return snapshot.hasData ?  ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = snapshot.data.documents[index];
                    return Container(
                      child: ListCard(
                        commodityName: doc['itemName'],
                        sellerName: doc['sellerName'],
                        myPrice: doc['price'],
                        quantity: doc['quantity'],
                        commodityPrice: doc['itemPrice'],
                        status: doc['status'],
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



