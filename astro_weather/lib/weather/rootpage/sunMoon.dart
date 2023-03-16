import 'dart:ui';
import 'package:astro_weather/weather/infopage/info.dart';
import 'package:astro_weather/weather/starspage/stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    return Expanded(
      child: LayoutBuilder(
        builder: (context, Constraints) {
          final size = Size(Constraints.maxWidth,Constraints.maxHeight);
          _path = Path();
          _path.moveTo(-MediaQuery.of(context).size.width * 0.25, size.height / 2);
          _path.quadraticBezierTo(
              size.width / 2, -size.height, size.width, size.height / 2);

          Positioned(
            top: calculate().dy,
            left: calculate().dx,
            child: Image.asset(
              (isNight) ? 'assets/weather/moon.png' : 'assets/weather/sun.png',
              width: 100,
              height: 100,
            ),
          );
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
          );
        },
      ),
    );
  }
}
