
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trooper_hackout/Screens/main_screen.dart';
import 'package:trooper_hackout/Screens/signup_form.dart';
import 'package:trooper_hackout/resources/color.dart';
import 'package:trooper_hackout/widgets/customButton.dart';
import 'package:trooper_hackout/widgets/heading_text.dart';
import 'package:trooper_hackout/widgets/textField.dart';

import 'NewsScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  FirebaseAuth _firebaseAuth  = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  final phoneNumberTEC = TextEditingController();

  final codeController = TextEditingController();


  String countryCode = "+91";
  int OTPText = 0;

  Future<bool> checkIfExist(String userId) async{

    Firestore firestore = Firestore.instance;

    try{
      dynamic data = await firestore.collection("Users").document(userId).get().then((value) {
        if(value==null) return false;
      });
      if(data == null) return false;
      return true;
    }
    catch(exception) {
      return false;
    }
    return true;
  }



  Future  <bool> loginUser(BuildContext context) async{

    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: countryCode + phoneNumberTEC.text,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          AuthResult result = await _firebaseAuth.signInWithCredential(credential);
          FirebaseUser user = result.user;
          if(user!=null) {


            bool status = await checkIfExist(user.uid);

            if(status == true) {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => MainScreen(),
              ));
            }
            else{
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => SignUpForm(userId: user.uid, phone:  phoneNumberTEC.text,),
              ));
            }
          }
        },
        verificationFailed: (AuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendToken]){
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code"),
                  content: Container(
                    height: MediaQuery.of(context).size.height*0.50,
                    child: Column(
                      children: [
                        CustomTextField(
                          label: "OTP",
                          type: TextInputType.number,
                          controller: codeController,
                        ),


                      ],
                    ),
                  ),

                  actions: [
                    CustomButton(
                      label: "Confirm",
                      color: secondary,
                      onPressed: () async {
                        AuthCredential credential = PhoneAuthProvider.getCredential(
                            verificationId: verificationId ,
                            smsCode: codeController.text.trim());

                        AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);

                        FirebaseUser user = authResult.user;


                        if(user!=null) {
                          bool status  = await checkIfExist(user.uid);
                          if(status == true) {
                            Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => MainScreen(),
                            ));
                          }
                          else{
                            Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => SignUpForm(userId: user.uid, phone:  phoneNumberTEC.text,),
                            ));
                          }
                        }


                      },
                    )
                  ],

                );
              }
          );
        },
        codeAutoRetrievalTimeout: null
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.2),

              HeadingText(
                "LOGIN"
              ),

              SizedBox(height: 60,),

              CustomTextField(
                controller: phoneNumberTEC,
                validator: (value){
                  if(value.isEmpty){
                    return "Please specify Phone Number";
                  }
                  else if(value.toString().length>10 || value.toString().length<10) {
                    return "Invalid Phone Number";
                  }
                  else{
                    return null;
                  }
                },
                label: "Phone Number",
                type: TextInputType.number,
              ),

              SizedBox(height: 30,),

              CustomButton(
                onPressed: (){
                  if(_formKey.currentState.validate()){
                    loginUser(context);
                  }
                },
                label: "Verify",
                color: secondary,
                labelColor: white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
