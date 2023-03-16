
import 'package:flutter/material.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

class Land extends StatefulWidget {
  const Land({super.key});

  @override
  State<Land> createState() => LandState();
}

class LandState extends State<Land>{
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
        color: Colors.purple,
        height: 100,
      ),
    );
  }
}
