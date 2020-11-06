import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trooper_hackout/Buy_sell.dart';
import 'package:trooper_hackout/Market.dart';
import 'package:trooper_hackout/acount.dart';
import 'package:trooper_hackout/crop_virus.dart';
import 'package:trooper_hackout/news.dart';
import 'package:trooper_hackout/resources/color.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  bool keyboardOpen = false;
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    News(),
    Market(),
    CropVirus(),
    Account()
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = News();

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() => keyboardOpen = visible);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: keyboardOpen ? SizedBox() : FloatingActionButton(
        backgroundColor: primary,
        child: Icon(
            Icons.add,
        color: Colors.white,),
        onPressed: () {
          setState(() {
            currentScreen = BuySell();
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            News(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.chrome_reader_mode_rounded,
                          color: currentTab == 0 ? primary : Colors.grey,
                        ),
                        Text(
                          'News',
                          style: TextStyle(
                            color: currentTab == 0 ? primary : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                          Market(); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.corporate_fare_sharp,
                          color: currentTab == 1 ? primary : Colors.grey,
                        ),
                        Text(
                          'Market',
                          style: TextStyle(
                            color: currentTab == 1 ? primary : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            CropVirus(); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.dashboard_rounded,
                          color: currentTab == 2 ? primary : Colors.grey,
                        ),
                        Text(
                          'BuySell',
                          style: TextStyle(
                            color: currentTab == 2 ? primary : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            BuySell(); // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person_rounded,
                          color: currentTab == 3 ? primary : Colors.grey,
                        ),
                        Text(
                          'Account',
                          style: TextStyle(
                            color: currentTab == 3 ? primary : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}