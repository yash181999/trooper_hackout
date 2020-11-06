import 'package:flutter/material.dart';
import 'package:trooper_hackout/widgets/textField.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [

            SizedBox(height: MediaQuery.of(context).size.height*10,),

            Container(
              alignment: Alignment.center,
              child: Text(
                "Details",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'sf_pro_bold',
                  fontSize: 28,
                ),
              ),
            ),

            SizedBox(height: 20,),

            CustomTextField(
              label: "Name",
            ),








          ],
        ),
      ),
    );
  }
}
