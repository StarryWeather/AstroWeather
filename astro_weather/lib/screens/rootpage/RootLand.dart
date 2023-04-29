import 'package:flutter/material.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:astro_weather/global.dart' as globals;
class Land extends StatefulWidget {
  const Land({super.key});

  @override
  State<Land> createState() => LandState();
}

class LandState extends State<Land> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
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
                  globals.currentTemp.toString(),
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
              width: 120,
              height: 50,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "53% Rain",
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
    );
  }
}
