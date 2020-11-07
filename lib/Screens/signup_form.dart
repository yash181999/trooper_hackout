import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trooper_hackout/Screens/main_screen.dart';
import 'package:trooper_hackout/database/auth.dart';
import 'package:trooper_hackout/resources/color.dart';
import 'package:trooper_hackout/widgets/customButton.dart';
import 'package:trooper_hackout/widgets/textField.dart';

class SignUpForm extends StatefulWidget {

  final userId, phone;
  SignUpForm({this.userId,this.phone});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  String empty = "Value should not be empty";

  final nameController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Firestore firestore = Firestore.instance;

  bool clicked = false;


  submitToDatabase() async{

   if(_formKey.currentState.validate()) {

     setState(() {
       clicked = true;
     });
     await firestore.collection("Users").document(widget.userId).setData({

     "name" : nameController.text,
     "district" : districtController.text,
     "state" : stateController.text,
     "phone" : widget.phone,

     });

     await AuthService.saveUserNameSharedPref(nameController.text);
     await AuthService.saveUserIdSharedPref(widget.userId);

     Navigator.pushReplacement(context, MaterialPageRoute(
       builder: (context) => MainScreen(),
     ));

     setState(() {
       clicked = false;
       districtController.text = "";
       stateController.text = "";
       nameController.text = "";
     });


   }else{


   }


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 50,),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Details",
                    style: TextStyle(
                      color: black,
                      fontFamily: 'sf_pro_bold',
                      fontSize: 28,
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                CustomTextField(
                  controller: nameController,
                  validator: (value) {
                    if(value.isEmpty){
                      return empty;
                    }
                    return null;
                  },
                  label: "Name",
                ),

                CustomTextField(
                  controller: districtController,
                  validator: (value) {
                    if(value.isEmpty) {
                      return empty;
                    }
                    return null;
                  },
                  label: "District",
                ),

                CustomTextField(
                  validator: (value) {
                    if(value.isEmpty) {
                      return empty;
                    }
                    return null;
                  },
                  controller: stateController,
                  label: "State",
                ),

                SizedBox(height: 20,),


                clicked == false ? CustomButton(
                  label: "Submit",
                  onPressed: (){
                    submitToDatabase();
                  },
                  color: secondary,
                  labelColor: white,
                ) : Center(
                    child: CircularProgressIndicator(),

                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
