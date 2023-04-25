import 'package:astro_weather/screens/infopage/info.dart';
import 'package:astro_weather/screens/rootpage/rootStars.dart';
import 'package:astro_weather/screens/rootpage/rootLand.dart';
import 'package:astro_weather/screens/rootpage/rootSunMoon.dart';
import 'package:astro_weather/screens/starspage/stars.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RootPage extends StatefulWidget {
  final String accessToken;
  const RootPage({required this.accessToken, Key? key}) : super(key: key);
  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  void getLocation() async
  {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print(position);
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
                        Container(
                          //this might need to be a stack find out later
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  AssetImage('assets/weather/clouds.png'),
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
                              child: Land(),
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
