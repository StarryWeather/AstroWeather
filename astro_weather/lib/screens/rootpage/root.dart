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

  void updateState() {
    setState(() {
      this.temp = globals.currentTemp;
      this.cloudIndex = globals.cloudIndex;
      this.weatherDesc = globals.weatherDescription;
      this.DN = globals.DayNight;
      this.skyColor = globals.skyColor;
    });
  }

  @override
  void initState() {
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
                decoration: BoxDecoration(gradient: skyColor),
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
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.55,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: (DN == "d")
                                        ? AssetImage(
                                            'assets/weather/xpgrass.png')
                                        : AssetImage(
                                            'assets/weather/nightxpgrass.png'),
                                    opacity: 1,
                                    fit: BoxFit.fill,
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
