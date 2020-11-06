import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'auth.dart';


class DatabaseService {
  Firestore db = Firestore.instance;

  bool accountBusiness;

  Future<bool> getAccountType() async {
    return await AuthService.getBusinessAccount();
  }

  Future<dynamic> createUserInDatabase(
      {String email, String userId, String name, String profilePic, String phone}) async {
    try {
      await db.collection('Users').document(userId).setData({
        'email': email,
        'name': name,
        'profilePic': profilePic,
        'phone': phone,
        "accountType": await getAccountType() == true ? "Business" : "normal",
      });
    }
    catch (e) {
      print(e.toString());
    }
  }


  Future<dynamic> getUserDataFromFireStore({String userId}) async {
    List<String> userData;

    await db.collection("Users").document(userId).get().then((value) {
      userData.add(value.data['Name']);
      userData.add(value.data['email']);
      return userData;
    });
  }


  Future<dynamic> saveUserDetailsFireStore({String userId, String name, String phoneNumber, String aadharNumber, String address, String city, String state, DateTime dateOfBirth}) async{

    try{

      await db.collection("Users").document(userId).updateData({
          'Name' : name,
          'phoneNumber' : phoneNumber,
          'aadharNumber' : aadharNumber,
          'address' : address,
          'city' : city,
          'state' : state,
          'dateOfBirth': dateOfBirth,

      }).whenComplete(() {
        print("Data Added");
      }).catchError((error){
         print(error);
      });

    }catch(e){
      return e;
    }

  }
}