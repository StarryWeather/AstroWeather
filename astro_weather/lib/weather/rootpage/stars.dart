import 'package:flutter/material.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

class Stars extends StatefulWidget {
  const Stars({super.key});

  @override
  State<Stars> createState() => StarsState();
}

class StarsState extends State<Stars> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipPath(
        clipper: ProsteBezierCurve(
          position: ClipPosition.bottom,
          list: [
            BezierCurveSection(
              start: Offset(0, MediaQuery.of(context).size.height * 0.10),
              top: Offset(MediaQuery.of(context).size.width / 2,
                  MediaQuery.of(context).size.height * 0.10 - 32.5),
              end: Offset(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.10),
            ),
          ],
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.10,
          color: Colors.red,
        ),
      ),
    );
  }
}
