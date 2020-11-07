import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trooper_hackout/database/auth.dart';
import 'package:trooper_hackout/resources/color.dart';
import 'package:trooper_hackout/widgets/app_bar.dart';
import 'package:trooper_hackout/widgets/customButton.dart';
import 'package:trooper_hackout/widgets/custom_text.dart';
import 'package:trooper_hackout/widgets/heading_text.dart';
import 'package:trooper_hackout/widgets/textField.dart';

class SellScreen extends StatefulWidget {
  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Firestore firestore = Firestore.instance;

  AuthService _authService = AuthService();

  final address = TextEditingController();
  final district = TextEditingController();
  final state = TextEditingController();
  final itemName = TextEditingController();
  final quantity = TextEditingController();
  final nameController = TextEditingController();
  final price = TextEditingController();

  final imagePicker = ImagePicker();
  File file;

  bool clickSubmit = false;

  final _formKey = GlobalKey<FormState>();

  void uploadBidToDatabase() async {
    if (_formKey.currentState.validate() && file != null) {
      setState(() {
        clickSubmit = true;
      });

      StorageUploadTask image = FirebaseStorage.instance
          .ref()
          .child("Activity")
          .child(userId)
          .child(Timestamp.now().toString())
          .child("Image")
          .putFile(file);

      final StorageTaskSnapshot imageDownloadUrl = (await image.onComplete);
      final String imageFile = await imageDownloadUrl.ref.getDownloadURL();

      await firestore.collection("Sell").document().setData({
        "timeStamp": Timestamp.now(),
        "name": name,
        "itemName": itemName.text,
        "quantity": quantity.text,
        "address": address.text,
        "district": district.text,
        "userId": userId,
        "state": state.text,
        "photo": imageFile,
        "price": price.text,
      });

      setState(() {
        clickSubmit = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();
    getLocation();
  }

  String name = "";
  String userId = "";
  getName() async {
    await AuthService.getUserNameSharePref().then((value) {
      setState(() {
        name = value;
        nameController.text = value;
      });
      print(value);
    });

    await AuthService.getUserIdSharedPref().then((value) {
      setState(() {
        userId = value;
      });
    });
  }

  //listcard widget
  Widget ListCard(
      {dynamic commodityName,
      dynamic sellerName,
      dynamic price,
      dynamic quantity,
      dynamic location,
      dynamic btnOnClick}) {
    return Column(
      children: [
        Card(
          child: Container(
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
                      text: commodityName,
                    )
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    CustomText(
                      fontFamily: 'sf_pro_bold',
                      text: "Seller Name : ",
                      fontSize: 14.0,
                    ),
                    CustomText(
                      fontFamily: 'sf_pro_regular',
                      text: sellerName,
                      fontSize: 14.0,
                    )
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    CustomText(
                      fontFamily: 'sf_pro_bold',
                      text: "Price : ",
                      fontSize: 14.0,
                    ),
                    CustomText(
                      fontFamily: 'sf_pro_regular',
                      text: price,
                      fontSize: 14.0,
                    )
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    CustomText(
                      fontFamily: 'sf_pro_bold',
                      text: "Quantity : ",
                      fontSize: 14.0,
                    ),
                    CustomText(
                      fontFamily: 'sf_pro_regular',
                      text: quantity,
                      fontSize: 14.0,
                    )
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
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
                          text: location,
                          fontSize: 14.0,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                CustomButton(
                  label: "View",
                  onPressed: () {
                    btnOnClick();
                  },
                  color: secondary,
                  labelColor: white,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
  //listcard widget

  //getting current location..
  dynamic getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final coordinates =
          new Coordinates(position.latitude, position.longitude);
      final addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);

      //fill address automatically in fields;
      address.text += addresses.first.addressLine;
      district.text += addresses.first.subAdminArea;
      state.text += addresses.first.adminArea;

      return addresses.first.featureName;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title: "Sell Agriculture Goods"),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),

                Container(
                  child: HeadingText(
                    "Upload Photo",
                  ),
                ),

                SizedBox(
                  height: 5,
                ),

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
                        child: InkWell(
                            onTap: () async {
                              if (file == null) {
                                dynamic imageFile = await imagePicker.getImage(
                                    source: ImageSource.gallery);

                                setState(() {
                                  file = File(imageFile.path);
                                });
                              } else {
                                setState(() {
                                  file = null;
                                });
                              }
                            },
                            child: file == null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      color: secondary,
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          size: 50,
                                          color: white,
                                        ),
                                      ),
                                    ),
                                  )
                                : Image(
                                    fit: BoxFit.cover,
                                    image: FileImage(file),
                                  )),
                      ),
                    ),
                  ),
                ),

                //name field
                CustomTextField(
                  label: "Your Name",
                  controller: nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Field empty";
                    }
                    return null;
                  },
                ),

                //item name
                CustomTextField(
                  label: "Item Name",
                  controller: itemName,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Field empty";
                    }
                    return null;
                  },
                ),

                CustomTextField(
                  label: "Quantity",
                  controller: quantity,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Field empty";
                    }
                    return null;
                  },
                ),

                CustomTextField(
                  label: "Price",
                  controller: price,
                  type: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Field empty";
                    }
                    return null;
                  },
                ),

                //address Field
                CustomTextField(
                  label: "Address",
                  controller: address,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Field empty";
                    }
                    return null;
                  },
                ),

                //district
                CustomTextField(
                  label: "District",
                  controller: district,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Field empty";
                    }
                    return null;
                  },
                ),

                //state field
                CustomTextField(
                  label: "State",
                  controller: state,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Field empty";
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 10,
                ),

                clickSubmit == false
                    ? CustomButton(
                        color: secondary,
                        labelColor: white,
                        onPressed: () {
                          uploadBidToDatabase();
                        },
                        label: "SUBMIT",
                      )
                    : Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
