import 'dart:ui';
import 'package:astro_weather/weather/info.dart';
import 'package:astro_weather/weather/stars.dart';
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
    _path = drawPath();
  }

  @override
  void dispose() {
    super.dispose();
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
                children: <Widget>[
                  Positioned(
                    top: 0,
                    child: CustomPaint(
                      painter: PathPainter(_path),
                    ),
                  ),
                  Positioned(
                    top: calculate().dy,
                    left: calculate().dx,
                    child: Image.asset(
                      (isNight)
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

  Path drawPath() {
    Size size = Size(300, 150);
    Path path = Path();
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(
        size.width / 2, -size.height, size.width + 35, size.height / 2);
    return path;
  }
}

class PathPainter extends CustomPainter {
  Path path;

  PathPainter(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.redAccent.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawPath(this.path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
