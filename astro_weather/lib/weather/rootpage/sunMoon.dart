import 'dart:ui';
import 'package:astro_weather/weather/infopage/info.dart';
import 'package:astro_weather/weather/starspage/stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

class SunMoon extends StatefulWidget {
  const SunMoon({super.key});

  @override
  State<SunMoon> createState() => SunMoonState();
}

class SunMoonState extends State<SunMoon> with SingleTickerProviderStateMixin {
  double timeOfDay = 0.0;
  bool isNight = false;

  late Path _path;

  @override
  void initState() {
    super.initState();
  }

  void updateTimeOfDay(double newValue) {
    setState(() {
      timeOfDay = newValue;
    });
  }

  Offset calculate() {
    PathMetrics pathMetrics = _path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    double value = pathMetric.length * timeOfDay;

    Tangent? pos = pathMetric.getTangentForOffset(value);
    return pos!.position;
  }

  @override
  Widget build(BuildContext context) {
    final size = Size(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.width / 2);
    _path = Path();
    _path.moveTo(-size.width * 0.15, size.height / 2);
    // checks if mobile or website
    if (kIsWeb) {
      _path.quadraticBezierTo(
          size.width / 2, -size.height, size.width * 1.09, size.height / 2);
    } else {
      _path.quadraticBezierTo(
          size.width / 2, -size.height, size.width * 0.90, size.height / 2);
    }

    return Expanded(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: calculate().dy + size.height * 0.3,
            left: calculate().dx,
            child: Image.asset(
              (isNight) ? 'assets/weather/moon.png' : 'assets/weather/sun.png',
              width: 100,
              height: 100,
            ),
          ),
          Slider(
            value: timeOfDay,
            onChanged: (value) {
              setState(() {
                timeOfDay = value;
                if (timeOfDay == 1.0 && !isNight) {
                  timeOfDay = 0.0;
                  isNight = true;
                } else if (timeOfDay == 1.0 && isNight) {
                  timeOfDay = 0.0;
                  isNight = false;
                }
              });
            },
            min: 0.0,
            max: 1.0,
            divisions: 48,
          ),
        ],
      ),
    );
  }
}
