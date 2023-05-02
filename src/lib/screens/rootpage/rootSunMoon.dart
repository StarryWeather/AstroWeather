import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:astro_weather/global.dart' as globals;

class SunMoon extends StatefulWidget {
  const SunMoon({super.key});

  @override
  State<SunMoon> createState() => SunMoonState();
}

class SunMoonState extends State<SunMoon> with SingleTickerProviderStateMixin {
  double currTime = 0.05 * (DateTime.now().hour.toDouble() + 1) - 0.35;
  bool isNight = globals.DayNight == 'n';

  late Path _path;

  @override
  void initState() {
    super.initState();
  }

  void updateTimeOfDay(double newValue) {
    setState(() {
      currTime = newValue;
      isNight = globals.DayNight == 'n';
    });
  }

  Offset calculate() {
    PathMetrics pathMetrics = _path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    double value = pathMetric.length * currTime;

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
          size.width / 2, -size.height, size.width * 1.09, size.height / .65);
    } else {
      _path.quadraticBezierTo(
          size.width / 2, -size.height, size.width * 0.90, size.height / 2);
    }

    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: calculate().dy + size.height * 0.01,
            left: calculate().dx,
            child: Image.asset(
              (isNight) ? 'assets/weather/moon.png' : 'assets/weather/sun.png',
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.height * 0.35,
            ),
          ),
        ],
      ),
    );
  }
}
