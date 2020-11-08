import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import './call.dart';

class IndexPage extends StatefulWidget {

  final sellerId, userId, sellerName, userName,documentId;
  IndexPage({this.sellerId,this.sellerName,this.userName,this.userId,this.documentId});

  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    // dispose input controller
    updateStaus();
    _channelController.dispose();
    Navigator.of(context).pop();
    super.dispose();
  }


  updateStaus() async {
    await Firestore.instance.collection("VideoCall").document(widget.documentId).updateData(
        {
          "status" : "offline",
        });
  }


  void initState() {
    super.initState();
    onJoin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agora Flutter QuickStart'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Column(
            children: <Widget>[
              // Row(
              //   children: <Widget>[
              //     Expanded(
              //         child: TextField(
              //       controller: _channelController,
              //       decoration: InputDecoration(
              //         errorText:
              //             _validateError ? 'Channel name is mandatory' : null,
              //         border: UnderlineInputBorder(
              //           borderSide: BorderSide(width: 1),
              //         ),
              //         hintText: 'Channel name',
              //       ),
              //     ))
              //   ],
              // ),
              // Column(
              //   children: [
              //     ListTile(
              //       title: Text(ClientRole.Broadcaster.toString()),
              //       leading: Radio(
              //         value: ClientRole.Broadcaster,
              //         groupValue: _role,
              //         onChanged: (ClientRole value) {
              //           setState(() {
              //             _role = value;
              //           });
              //         },
              //       ),
              //     ),
              //     ListTile(
              //       title: Text(ClientRole.Audience.toString()),
              //       leading: Radio(
              //         value: ClientRole.Audience,
              //         groupValue: _role,
              //         onChanged: (ClientRole value) {
              //           setState(() {
              //             _role = value;
              //           });
              //         },
              //       ),
              //     )
              //   ],
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 20),
              //   child: Row(
              //     children: <Widget>[
              //       Expanded(
              //         child: RaisedButton(
              //           onPressed: onJoin,
              //           child: Text('Join'),
              //           color: Colors.blueAccent,
              //           textColor: Colors.white,
              //         ),
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation


      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: widget.userId,
            role: _role,
          ),
        ),
      );

  }

  Future<void> _handleCameraAndMic() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();
  }
}
