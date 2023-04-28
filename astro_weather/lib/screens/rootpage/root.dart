import 'package:astro_weather/screens/infopage/info.dart';
import 'package:astro_weather/screens/rootpage/rootStars.dart';
import 'package:astro_weather/screens/rootpage/rootLand.dart';
import 'package:astro_weather/screens/rootpage/rootSunMoon.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:astro_weather/screens/starspage/stars.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:astro_weather/global.dart' as globals;

class RootPage extends StatefulWidget {
  final String accessToken;
  const RootPage({required this.accessToken, Key? key}) : super(key: key);
  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  void getLocation() async
  {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print(position);
                                 var url = Uri.parse(
                                      'https://api.weatherbit.io/v2.0/current?lat='+position.latitude.toString()+'&lon='+position.longitude.toString()+'&key=dffbf9e2ee24421f8cb8e89f078664df');

                                  var response = await http.post(url,
                                      headers: {
                                        "Content-Type": "application/json"
                                      });
                                  // check if valid
                                  if (response.statusCode == 200) {

                                    // true: go to root
                                    debugPrint('Made it in here: pass');
                                    var responseJSON =
                                        json.decode(response.body);
                                    debugPrint(responseJSON['TimeZone']);
                                    var temps = responseJSON['data'][0]['temp'];
                                    
                                    temps = ((temps)*1.8)+32;
                                    temps = temps.round();
                                    globals.currentTemp = temps.toString();

                                    var clouds = responseJSON['data'][0]['clouds'];
                                    if(clouds > 70)
                                    {
                                      globals.cloudIndex = 2;
                                    }
                                    else if(clouds > 50)
                                    {
                                      globals.cloudIndex = 1;
                                    }
                                    else
                                    {
                                      globals.cloudIndex = 0;
                                    }

                                    var desc = responseJSON['data'][0]['weather']['description'];
                                    globals.weatherDesc = desc;
                                    debugPrint(globals.currentTemp.toString());
                                    debugPrint(globals.cloudIndex.toString());

                                    updateState();
                                    //var responseJSON = json.decode(response.body);
                                  } else {
                                    // false: display email/password invalid
                                    debugPrint('Made it in here: fail');

                                  }
                                  
  }
  var temp;
  var cloudIndex;
  var weatherDesc;
  void updateState()
  {
    setState(() {
      this.temp = globals.currentTemp;
      this.cloudIndex = globals.cloudIndex;
      this.weatherDesc = globals.weatherDesc;
    });

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
        } else if (details.delta.dy > 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StarPage()),
          );
        }
      },
      child: Scaffold(
        body: SizedBox.expand(
            child: Container(
                color: Colors.lightBlue,
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
                        if(cloudIndex == 0)
                          Container(
                            
                          ),
                        if(cloudIndex == 1)
                          Container(
                            decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                
                                AssetImage('assets/weather/50.png'),
                            ),
                          ),
                          height: MediaQuery.of(context).size.height/2,
                          ),
                        if(cloudIndex == 2)
                          Container(
                            decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                
                                AssetImage('assets/weather/darkSky.png'),
                            ),
                          ),
                          height: MediaQuery.of(context).size.height/2,
                          ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StarPage()));
                          },
                          child: Stars(),
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
            start: Offset(MediaQuery.of(context).size.width, 35),
            top: Offset(MediaQuery.of(context).size.width / 2, 0),
            end: Offset(0, 35),
          ),
        ],
      ),
      child: Container(
        color: Colors.green,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(121, 158, 158, 158),
                  border: Border.all(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              width: 120,
              height: 50,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  this.temp.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'KdamThmorPro',
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(121, 158, 158, 158),
                  border: Border.all(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
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
                    color: Color.fromARGB(255, 0, 0, 0),
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
                        Container(
                          child: ElevatedButton(
                                onPressed: getLocation,
                                child: const Text('location'),
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
