import 'package:astro_weather/weather/info.dart';
import 'package:astro_weather/weather/stars.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  // **get time of day**
  double timeOfDay = 0.0;
  bool isNight = false;

  @override
  Widget build(BuildContext context) {
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
            ClipPath(
              clipper: ProsteBezierCurve(
                position: ClipPosition.bottom,
                list: [
                  BezierCurveSection(
                    start: Offset(0, 150),
                    top: Offset(MediaQuery.of(context).size.width / 2, 117.5),
                    end: Offset(MediaQuery.of(context).size.width, 150),
                  ),
                ],
              ),
              child: Container(
                height: 150,
                color: Colors.red,
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    left: (MediaQuery.of(context).size.width - 100) * timeOfDay,
                    child: Image.asset(
                      (isNight == true)
                          ? 'assets/weather/moon.png'
                          : 'assets/weather/sun.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Slider(
                    value: timeOfDay,
                    onChanged: (value) {
                      setState(() {
                        timeOfDay = value;
                        if (timeOfDay == 1.0 && isNight == false) {
                          timeOfDay = 0.0;
                          isNight = true;
                        } else if (timeOfDay == 1.0 && isNight == true) {
                          timeOfDay = 0.0;
                          isNight = false;
                        }
                      });
                    },
                    min: 0.0,
                    max: 1.0,
                    divisions: 1200,
                  ),
                ],
              ),
            ),
            ClipPath(
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
                color: Colors.purple,
                height: 150,
              ),
            )
          ],
        ),
      ),
    );
  }
}
