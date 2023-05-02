import 'package:astro_weather/screens/navigator.dart';
import 'package:astro_weather/screens/rootpage/rootLand.dart';
import 'package:astro_weather/screens/rootpage/rootSunMoon.dart';
import 'package:astro_weather/screens/starspage/starview.dart';
import 'package:astro_weather/utils/weatherAPI.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:astro_weather/screens/starspage/stars.dart';
import 'package:astro_weather/screens/rootpage/rootStars.dart';
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
    return Scaffold(
        body: SizedBox.expand(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(gradient: skyColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(15, 255, 255, 255),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Current Temp: "+globals.currentTemp + "\u00B0",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'KdamThmorPro',
                                        ),
                                      ),
                                      Text(
                                        "Real Feel: "+globals.realFeel + "\u00B0",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'KdamThmorPro',
                                        ),
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.width * 0.02,),
                                      Text(
                                        globals.weatherDescription,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'KdamThmorPro',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.55,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: (DN == "d")
                                    ? AssetImage('assets/weather/xpgrass.png')
                                    : AssetImage(
                                        'assets/weather/nightxpgrass.png'),
                                opacity: 1,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
