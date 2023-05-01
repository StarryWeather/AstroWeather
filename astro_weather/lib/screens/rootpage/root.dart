import 'package:astro_weather/screens/rootpage/rootLand.dart';
import 'package:astro_weather/screens/rootpage/rootSunMoon.dart';
import 'package:astro_weather/utils/weatherAPI.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:astro_weather/global.dart' as globals;

import '../infopage/info.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);
  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  var temp;
  var cloudIndex;
  var weatherDesc;
  var DN;
  var skyColor;

  void updateState(){
    setState(() {
      this.temp = globals.currentTemp;
      this.cloudIndex = globals.cloudIndex;
      this.weatherDesc = globals.weatherDescription;
      this.DN = globals.DayNight;
      this.skyColor = globals.skyColor;
    });
  }

  @override
  void initState(){
    updateState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy < 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InfoPage()),
          );
        }
      },
      child: Scaffold(
        body: SizedBox.expand(
            child: Container(
                color: skyColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          //this might need to be a stack find out later
                          child: SunMoon(),
                          height: MediaQuery.of(context).size.height,
                        ),
                        if (cloudIndex == 0) Container(),
                        if (cloudIndex == 1)
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/weather/50.png'),
                              ),
                            ),
                            height: MediaQuery.of(context).size.height / 2,
                          ),
                        if (cloudIndex == 2)
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/weather/darkSky.png'),
                              ),
                            ),
                            height: MediaQuery.of(context).size.height / 2,
                          ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InfoPage()));
                              },
                              child: ClipPath(
                                clipper: ProsteBezierCurve(
                                  position: ClipPosition.top,
                                  list: [
                                    BezierCurveSection(
                                      start: Offset(
                                          MediaQuery.of(context).size.width,
                                          35),
                                      top: Offset(
                                          MediaQuery.of(context).size.width / 2,
                                          0),
                                      end: Offset(0, 35),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  color: Colors.green,
                                  height: 100,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                121, 158, 158, 158),
                                            border: Border.all(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        width: 120,
                                        height: 50,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            this.temp.toString() + '°',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontFamily: 'KdamThmorPro',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                121, 158, 158, 158),
                                            border: Border.all(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        width: 240,
                                        height: 50,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            this.weatherDesc.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontFamily: 'KdamThmorPro',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))),
      ),
    );
  }
}
