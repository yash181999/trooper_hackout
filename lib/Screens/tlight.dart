import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';

import 'package:trooper_hackout/widgets/app_bar.dart';

class Tlight extends StatefulWidget {
  @override
  _TlightState createState() => _TlightState();
}

class _TlightState extends State<Tlight> {

  File Pickedimage;
  bool isimageloded = false;

  List _result;
  String _confidence = "";
  String _name = "";
  String numbers = "";

  getImageFormGallery() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      Pickedimage = File(tempStore.path);
      isimageloded = true;
      applyModelOnImage(Pickedimage);
    });
  }

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
      backgroundColor: Colors.white,
      appBar: appbar(title: "Agriculture Solution"),

      body: Container(
        child: Column(
          children: [
            SizedBox(height: 30,),
            isimageloded ? Center(
              child: Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(Pickedimage.path)),
                    fit: BoxFit.contain
                  )
                ),
              ),
            ) : Container(),
            SizedBox(height: 10,),
         Text("Name : $_name \n Confidence : $_confidence"),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImageFormGallery();
        },
        child: Icon(
          Icons.photo_album
        ),
      ),
    );
  }
}
