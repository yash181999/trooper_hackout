import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trooper_hackout/database/auth.dart';
import 'package:trooper_hackout/resources/color.dart';
import 'package:trooper_hackout/video_call/pages/index.dart';
import 'package:trooper_hackout/widgets/app_bar.dart';
import 'package:trooper_hackout/widgets/customButton.dart';
import 'package:trooper_hackout/widgets/custom_text.dart';
import 'package:trooper_hackout/widgets/heading_text.dart';
import 'package:flutter_sms/flutter_sms.dart';


class SellerInfo extends StatefulWidget {
  final sellerId,photo, address, state, district, sellerName, price, quantity,itemName,sellerTokenId,documentId;
  SellerInfo({this.sellerId,this.price,this.itemName,this.photo,this.quantity,this.sellerName,this.state,this.district,this.documentId
    ,this.address,this.sellerTokenId});


  @override
  _SellerInfoState createState() => _SellerInfoState();
}

class _SellerInfoState extends State<SellerInfo> {



  _sendSMS() async {
    List<String> recipients = ["8561030805"];
    String _result = await sendSMS(message: "Hi vinay kesa he me Yash ", recipients: recipients).catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  initState() {
    super.initState();
    getUserId();
  }

  String userId = '';
  String userName = '';
  String token = '';

  Firestore _firestore = Firestore.instance;

  getUserId() async{
     await AuthService.getUserIdSharedPref().then((value) {
       setState(() {
         userId = value;
       });
     });

     await AuthService.getUserNameSharePref().then((value) {
        setState(() {
          userName = value;
        });
     });

     await AuthService.getUserDeviceToken().then((value) {
       setState(() {
         token = value;
       });
     });

  }

  bool clickedVideoCall = false;


  _videoCall() async{

    setState(() {
      clickedVideoCall = true;
    });

    await _firestore.collection("VideoCall").document().setData({

      "status" : "online",
      "timeStamp" : Timestamp.now(),
      "callerId" : userId,
      "receiverId": widget.sellerId,
      "callerName" : userName,
      "receiverName" : widget.sellerName,
      "senderTokenId" : token,
      "receiverTokenId" : widget.sellerTokenId,


    });

    setState(() {
      clickedVideoCall = false;
    });


     Navigator.push(context, MaterialPageRoute(
         builder : (context) => IndexPage(
           sellerId : widget.sellerId,
           sellerName: widget.sellerName,
           userId : userId,
           userName : userName,
           documentId: widget.documentId,
         )
     ));
  }


  //listcard widget
  Widget ListCard({dynamic commodityName,
    dynamic sellerName, dynamic price,
    dynamic quantity, dynamic location,
    dynamic btnOnClick}){
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child :  Center(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomText(
                          fontFamily: 'sf_pro_bold',
                          text: "Commodity : ",
                          fontSize: 22.0,
                        ),
                        CustomText(
                          fontFamily: 'sf_pro_regular',
                          text : commodityName,
                          fontSize: 18.0,

                        )
                      ],
                    ),

                    SizedBox(height: 5,),

                    Row(
                      children: [
                        CustomText(
                          fontFamily: 'sf_pro_bold',
                          text: "Seller Name : ",
                          fontSize: 22.0,
                        ),
                        CustomText(
                          fontFamily: 'sf_pro_regular',
                          text : sellerName,
                          fontSize: 18.0,

                        )
                      ],
                    ),

                    SizedBox(height: 5,),

                    Row(
                      children: [
                        CustomText(
                          fontFamily: 'sf_pro_bold',
                          text: "Price : ",
                          fontSize: 22.0,
                        ),
                        CustomText(
                          fontFamily: 'sf_pro_regular',
                          text : price,
                          fontSize: 18.0,
                        )
                      ],
                    ),

                    SizedBox(height: 5,),

                    Row(
                      children: [
                        CustomText(
                          fontFamily: 'sf_pro_bold',
                          text: "Quantity : ",
                          fontSize: 22.0,
                        ),
                        CustomText(
                          fontFamily: 'sf_pro_regular',
                          text : quantity,
                          fontSize: 18.0,
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
                              fontSize: 22.0,
                            ),
                          ),
                          Flexible(
                            child: CustomText(
                              fontFamily: 'sf_pro_regular',
                              text : location,
                              fontSize: 18.0,
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
      appBar: appbar(
        title : "Info",
      ),

      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10,top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    color: primary,
                    child: Center(
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                           widget.photo,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 10,),
              
              HeadingText(widget.itemName),

              SizedBox(height: 10,),

              ListCard(
                quantity: widget.quantity,
                commodityName: widget.itemName,
                price: widget.price,
                location: widget.address,
                sellerName: widget.sellerName,

              ),

              CustomButton(
                label: "BUY",
                labelColor: white,
                onPressed: (){},
                color: secondary,
              ),

              SizedBox(height: 10,),

              CustomButton(
                label: "Video Call",
                labelColor: white,
                onPressed: (){
                  _videoCall();
                },
                color: secondary,
              ),

              SizedBox(height: 10,),


              clickedVideoCall == false ? CustomButton(
                label: "Voice Call",
                labelColor: white,
                onPressed: (){
                  setState(() {
                    clickedVideoCall = true;
                  });
                },
                color: secondary,
              ) : Center(
                child: CircularProgressIndicator(),
              ),

              SizedBox(height: 10,),

              CustomButton(
                label: "Message",
                labelColor: white,
                onPressed: (){
                 _sendSMS();
                },
                color: secondary,
              ),





            ],
          ),
        ),
      ),

    );
  }
}
