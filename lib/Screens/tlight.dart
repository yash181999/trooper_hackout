
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:trooper_hackout/Screens/NavDrawer.dart';
import 'package:trooper_hackout/resources/color.dart';
import 'dart:io';
import 'package:trooper_hackout/widgets/app_bar.dart';
import 'package:trooper_hackout/widgets/custom_text.dart';
import 'package:trooper_hackout/widgets/heading_text.dart';
import 'package:trooper_hackout/widgets/red_button.dart';

class Tlight extends StatefulWidget {
  @override
  _TlightState createState() => _TlightState();
}

class _TlightState extends State<Tlight> {

  File Pickedimage;

  List _result;
  String _confidence = "";
  String _name = "";
  String numbers = "";

  String pesticideName = "";
  String precautions = "";

//  getImageFormGallery() async {
//    var tempStore = await ImagePicker().getImage(source: ImageSource.gallery);
//    setState(() {
//      Pickedimage = File(tempStore.path);
//      applyModelOnImage(Pickedimage);
//    });
//  }

  loadMyModel() async{
    var result = await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt"
    );

  }

  applyModelOnImage(File file)async {
    var res = await Tflite.runModelOnImage(
        path: file.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5
    );







    //print("model result : $res");
    setState(() {
      _result = res;
       String str = _result[0]["label"];
       _name = str.substring(2);
       _confidence = _result != null ? (_result[0]['confidence']*100.0).toString().substring(0, 2) + "" : "";

    });




    await Firestore.instance.collection("Solution").getDocuments().then((value) {


      for(int i=0;i<value.documents.length;i++) {
        if(value.documents[i]['DiseaseName'] == _name) {
          setState(() {
            precautions = value.documents[i]['Precautions'];
            pesticideName = value.documents[i]['PesticideName'];
          });
        }
      }



    });
    
    
    

    print(precautions);
    print(pesticideName);


  }

   @override
  void initState() {
    super.initState();
    loadMyModel();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: Colors.white,
      appBar: appbar(title: "Agriculture Solution"),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        icon: Icon(Icons.people),
        label: Text("Experts"),
        backgroundColor: secondary,
      ),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30,),
               HeadingText("Upload an Image"),
               SizedBox(height: 20,),
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
                            if (Pickedimage == null) {
                              dynamic imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
                              setState(() {
                                Pickedimage = File(imageFile.path);
                                applyModelOnImage(Pickedimage);

                              });
                            } else {
                              setState(() {
                                Pickedimage = null;
                              });
                            }
                          },
                          child: Pickedimage == null
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
                            image: FileImage(Pickedimage),
                          )),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10,),

              ListCard(
                pesticide: pesticideName,
                precautions: precautions,
                disease: _name,
              ),

            ],
          ),
        ),
      ),
    );
  }
}

//listcard widget
Widget ListCard({dynamic disease = "Loading..",
  dynamic precautions = "Loading.." , dynamic pesticide = "Loading..",}){
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
                        text: "Disease Name  : ",
                        fontSize: 18.0,
                      ),
                      Flexible(
                        child: CustomText(
                          fontFamily: 'sf_pro_regular',
                          text : disease,
                          fontSize: 18.0,

                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 5,),

                  Row(
                    children: [
                      CustomText(
                        fontFamily: 'sf_pro_bold',
                        text: "Pesticide: ",
                        fontSize: 18.0,
                      ),
                      Flexible(
                        child: CustomText(
                          fontFamily: 'sf_pro_regular',
                          text : pesticide,
                          fontSize: 18.0,

                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 5,),

                  Row(
                    children: [
                      CustomText(
                        fontFamily: 'sf_pro_bold',
                        text: "Precautions : ",
                        fontSize: 18.0,
                      ),
                      Flexible(
                        child: CustomText(
                          fontFamily: 'sf_pro_regular',
                          text : precautions,
                          fontSize: 18.0,
                        ),
                      )
                    ],
                  ),


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