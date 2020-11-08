import 'package:flutter/material.dart';
import 'package:trooper_hackout/Screens/received_requests.dart';
import 'package:trooper_hackout/resources/color.dart';

import 'my_requests.dart';

class Requests extends StatefulWidget {
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          title: Text("Requests",style: TextStyle(color: black, fontSize: 22),),

          bottom: TabBar(
            labelColor: black,
            tabs: [
              Tab(
                text: "My Requests",

              ),
              Tab(
                text: "Received Requests",
              )
            ],
          ),
        ),

        body: TabBarView(
          children: [
            MyRequests(),
            ReceivedRequests(),
          ],
        ),
      ),
    );
  }
}
