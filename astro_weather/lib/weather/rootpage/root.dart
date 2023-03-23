import 'package:astro_weather/weather/infopage/info.dart';
import 'package:astro_weather/weather/rootpage/stars.dart';
import 'package:astro_weather/weather/rootpage/land.dart';
import 'package:astro_weather/weather/rootpage/sunMoon.dart';
import 'package:astro_weather/weather/starspage/stars.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  final String accessToken;
  const RootPage({required this.accessToken, Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StarPage()));
              },
              child: Stars(),
            ),
            SunMoon(),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InfoPage()));
              },
              child: Land(),
            ),
          ],
        ),
      ),
    );
  }
}
