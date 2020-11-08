import 'package:flutter/material.dart';
import 'package:trooper_hackout/Screens/NavDrawer.dart';
import 'package:trooper_hackout/resources/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:trooper_hackout/resources/location.dart';
import 'package:trooper_hackout/resources/networking.dart';
import 'package:trooper_hackout/resources/weather_secret.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

import 'package:trooper_hackout/widgets/app_bar.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var temp;
  var description;
  var cuurently;
  var humidity;
  var windspeed;
  var name;
  double latitude;
  double longitude;

  Future<dynamic> getWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        'http://api.openweathermap.org/data/2.5/weather?q=indore&appid=$api_key&units=metric');
    var results = await networkHelper.getData();
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.cuurently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windspeed = results['wind']['speed'];
      this.name = results['name'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: appbar(
        title: "Current Weather",
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            color: Color(0xff718f47),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    temp != null
                        ? "Currently in " + name.toString()
                        : "Loading",
                    style: TextStyle(
                      color: Color(0xff89cf27),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Loading",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 40.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    cuurently != null ? cuurently.toString() : "Loading",
                    style: TextStyle(
                      color: Color(0xff89cf27),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometer),
                    title: Text('Temperature'),
                    trailing: Text(
                        temp != null ? temp.toString() + "\u00B0" : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text('Weather'),
                    trailing: Text(
                      description != null ? description.toString() : "Loading",
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text('Humidity'),
                    trailing: Text(
                      humidity != null ? humidity.toString() : "Loading",
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text('Wind Speed'),
                    trailing: Text(
                      windspeed != null
                          ? windspeed.toString() + "\u00B0"
                          : "Loading",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40.0),
            child: Container(
              height: 100,
              padding: EdgeInsets.all(10.0),
              child: ListView(
                // This next line does the trick.
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 90.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Mon, Nov 9',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        FaIcon(
                          FontAwesomeIcons.solidSun,
                          color: Colors.black38,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text('29° / 14°')
                      ],
                    ),
                  ),
                  Container(
                    width: 90.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tue, Nov 10',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        FaIcon(
                          FontAwesomeIcons.solidSun,
                          color: Colors.black38,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text('29° / 14°')
                      ],
                    ),
                  ),
                  Container(
                    width: 90.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Wed, Nov 11',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        FaIcon(
                          FontAwesomeIcons.solidSun,
                          color: Colors.black38,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text('29° / 14°')
                      ],
                    ),
                  ),
                  Container(
                    width: 90.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Thu, Nov 12',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        FaIcon(
                          FontAwesomeIcons.solidSun,
                          color: Colors.black38,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text('28° / 15°')
                      ],
                    ),
                  ),
                  Container(
                    width: 90.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Fri, Nov 13',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        FaIcon(
                          FontAwesomeIcons.solidSun,
                          color: Colors.black38,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text('29° / 15°')
                      ],
                    ),
                  ),
                  Container(
                    width: 90.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Sat, Nov 14',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        FaIcon(
                          FontAwesomeIcons.solidSun,
                          color: Colors.black38,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text('31° / 16°')
                      ],
                    ),
                  ),
                  Container(
                    width: 90.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Sun, Nov 15  ',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        FaIcon(
                          FontAwesomeIcons.solidSun,
                          color: Colors.black38,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text('32° / 17°')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
