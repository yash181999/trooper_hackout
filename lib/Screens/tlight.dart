import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:trooper_hackout/Screens/NavDrawer.dart';
import 'package:trooper_hackout/resources/color.dart';
import 'dart:io';
import 'package:trooper_hackout/widgets/app_bar.dart';
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

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 30,),
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
            Text("Name : $_name \n Confidence : $_confidence"),


            SizedBox(height: 50,),
            RedButton(btnTitle: "Experts", btnColor: primary, textColor: black,)
          ],
        ),
      ),
    );
  }
}
