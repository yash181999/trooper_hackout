import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trooper_hackout/resources/color.dart';
import 'package:trooper_hackout/widgets/app_bar.dart';
import 'package:trooper_hackout/widgets/customButton.dart';
import 'package:trooper_hackout/widgets/textField.dart';

class BuyProduct extends StatefulWidget {


  final sellerId, userId, sellerName, userName,documentId,itemName,itemPrice;
  BuyProduct({this.sellerId,this.sellerName,this.userName,this.userId,this.documentId, this.itemName, this.itemPrice});



  @override
  _BuyProductState createState() => _BuyProductState();
}

class _BuyProductState extends State<BuyProduct> {


  final _formKey =  GlobalKey<FormState>();

  Firestore _firestore = Firestore.instance;

  final address  = TextEditingController();
  final phone = TextEditingController();
  final quantity = TextEditingController();
  final price = TextEditingController();
  final name = TextEditingController();




  bool clicked = false;



  bidForProduct() async{

    if(_formKey.currentState.validate()) {

      setState(() {
        clicked = true;
      });

      await _firestore.collection("Buy").document().setData({

        "timeStamp" : Timestamp.now(),
        "buyerName" : name.text,
        "price": price.text,
        "quantity" : quantity.text,
        "address": address.text,
        "phone" : phone.text,
        "sellerId" : widget.sellerId,
        "buyerId" : widget.userId,
        "status" : "pending",
        "sellerName" : widget.sellerName,
        "itemName" : widget.itemName,
        "itemPrice" : widget.itemPrice,

      });


      setState(() {
        clicked = false;
        address.text = '';
        phone.text = '';
        name.text = '';
        quantity.text = '';
        price.text = '';

      });

      Navigator.pop(context);

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        title: "Buy Product",
      ),

      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
           key: _formKey,
            child: Column(
              children: [

                CustomTextField(
                  label: "Name",
                  validator: (value){
                    if(value.isEmpty) return "Field is Empty";
                    return null;
                  },
                  controller: name,
                ),

                CustomTextField(
                  label: "Phone Number",
                  type: TextInputType.number,
                  validator: (value){
                    if(value.isEmpty) return "Field is Empty";
                    return null;
                  },
                  controller: phone,
                ),


                CustomTextField(
                  label: "Price",
                  validator: (value){
                    if(value.isEmpty) return "Field is Empty";
                    return null;
                  },
                  controller: price,
                ),


                CustomTextField(
                  label: "Quantity",
                  validator: (value){
                    if(value.isEmpty) return "Field is Empty";
                    return null;
                  },
                  controller: quantity,
                ),


                CustomTextField(
                  label: "Address",
                  validator: (value){
                    if(value.isEmpty) return "Field is Empty";
                    return null;
                  },
                  controller: address,
                ),



                SizedBox(height: 20,),

                clicked == false ? CustomButton(
                  label: "SUBMIT",
                  color: secondary,
                  labelColor: white,
                  onPressed: (){
                    bidForProduct();
                  },
                ) : Center(
                  child: CircularProgressIndicator(),
                )


              ],
            ),

          ),
        ),
      ),

    );
  }
}
