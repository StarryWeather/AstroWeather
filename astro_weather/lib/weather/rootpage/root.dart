import 'dart:ui';
import 'package:astro_weather/weather/infopage/info.dart';
import 'package:astro_weather/weather/rootpage/land.dart';
import 'package:astro_weather/weather/rootpage/stars.dart';
import 'package:astro_weather/weather/rootpage/sunMoon.dart';
import 'package:astro_weather/weather/starspage/stars.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  // **get time of day**
  double timeOfDay = 0.0;
  bool isNight = false;

  late Path _path;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = Size(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.width / 2);
    _path = Path();
    _path.moveTo(-MediaQuery.of(context).size.width * 0.25, size.height / 2);
    _path.quadraticBezierTo(
        size.width / 2, -size.height, size.width, size.height / 2);

    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        final scrollDelta = notification.scrollDelta;
        if (scrollDelta != null && scrollDelta < 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StarPage()),
          );
        } else if (scrollDelta != null && scrollDelta > 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InfoPage()),
          );
        }
        return true;
      },
      child: Scaffold(
        body: Column(
          children: [
            Stars(),
            SunMoon(),
            Land(),
          ],
        ),
      ),
    );
  }
}
