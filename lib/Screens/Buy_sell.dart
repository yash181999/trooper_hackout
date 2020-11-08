import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:trooper_hackout/Screens/buy_screen.dart';
import 'package:trooper_hackout/Screens/requests.dart';
import 'package:trooper_hackout/Screens/sell_screen.dart';
import 'package:trooper_hackout/database/auth.dart';
import 'package:trooper_hackout/resources/color.dart';
import 'package:trooper_hackout/widgets/app_bar.dart';
import 'package:trooper_hackout/widgets/customButton.dart';
import 'package:trooper_hackout/widgets/heading_text.dart';
import 'package:trooper_hackout/widgets/red_button.dart';
import 'package:trooper_hackout/widgets/textField.dart';


class BuySell extends StatefulWidget {
  @override
  _BuySellState createState() => _BuySellState();
}

class _BuySellState extends State<BuySell> {

  final farmerName = TextEditingController();
  final phoneNumber = TextEditingController();
  final aadharNumber = TextEditingController();
  final address = TextEditingController();
  final district = TextEditingController();
  final state = TextEditingController();
  final _formKey =  GlobalKey<FormState>();

  Firestore _firestore = Firestore.instance;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  String userId = '';

  getUserId() async{
     await AuthService.getUserIdSharedPref().then((value) {
         setState(() {
           userId  = value;
         });
     });
  }

  bool clicked = false;

  saveFarmerToDatabase() async{


     if(_formKey.currentState.validate()) {
       setState(() {
         clicked  = true;
       });



      await _firestore.collection("Farmers").document().setData({

         "farmerName" : farmerName.text,
         "phone" : phoneNumber.text,
         "aadharNumber" : aadharNumber.text,
         "userId" : userId,
         "address" : address.text,
         "state" : state.text,
         "district" : district.text,

       });



       setState(() {
         clicked = false;
         farmerName.text = '';
         phoneNumber.text = '';
         aadharNumber.text = '';
         address.text = '';
         state.text = '';
         district.text = '';
       });
     }


  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            "Buy and Sell",
            style: TextStyle(
              color: white,
            ),
        ),

      ),

        body :  Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Form(
              key: _formKey,
              child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          height: 50,
                          minWidth: 150,
                          child: Text("Buy",style: TextStyle(fontSize: 18,color: white),),
                          color: secondary,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                               builder: (context) => BuyScreen(),
                            ));
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        MaterialButton(
                          height: 50,
                          minWidth: 150,
                          child: Text("Sell",style: TextStyle(fontSize: 18,color: white),),
                          color: secondary,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => SellScreen(),
                            ));
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 10,),

                    MaterialButton(
                      height: 50,
                      minWidth: 150,
                      child: Text("Requests",style: TextStyle(fontSize: 18,color: white),),
                      color: secondary,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Requests(),
                        ));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    SizedBox(height: 10,),


                    Divider(height: 0.3,color: black,),

                    HeadingText("Add A Farmer"),

                    Divider(height: 0.3,color: black,),

                    SizedBox(height: 10,),

                    CustomTextField(
                      label: "Farmer Name",
                      validator: (value){
                        if(value.isEmpty) return "Field is Empty";
                        return null;
                      },
                      controller: farmerName,
                    ),

                    CustomTextField(
                      label: "Phone Number",
                      type: TextInputType.number,
                      validator: (value){
                        if(value.isEmpty) return "Field is Empty";
                        return null;
                      },
                      controller: phoneNumber,
                    ),

                    CustomTextField(
                      label: "Aadhar Number",
                      type: TextInputType.number,
                      validator: (value){
                        if(value.isEmpty) return "Field is Empty";
                        return null;
                      },
                      controller: aadharNumber,
                    ),

                    CustomTextField(
                      label: "Address",
                      validator: (value){
                        if(value.isEmpty) return "Field is Empty";
                        return null;
                      },
                      controller: address,
                    ),

                    CustomTextField(
                      label: "District",
                      validator: (value){
                        if(value.isEmpty) return "Field is Empty";
                        return null;
                      },
                      controller: district,
                    ),

                    CustomTextField(
                      label: "State",
                      validator: (value){
                        if(value.isEmpty) return "Field is Empty";
                        return null;
                      },
                      controller: state,
                    ),

                    SizedBox(height: 20,),

                    clicked == false ? CustomButton(
                      label: "SUBMIT",
                      color: secondary,
                      labelColor: white,
                      onPressed: (){
                        saveFarmerToDatabase();
                      },
                    ) : Center(
                      child: CircularProgressIndicator(),
                    )

                  ],
                ),
              ),
            )
        ),
    );


  }
}
