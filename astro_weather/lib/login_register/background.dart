import 'dart:math';
import 'package:flutter/material.dart';
import 'package:starsview/starsview.dart';

import 'earth.dart';

class SetBackground extends StatefulWidget {
  const SetBackground({super.key});
  @override
  State<SetBackground> createState() => SetBackgroundState();
}

class SetBackgroundState extends State<SetBackground>
    with TickerProviderStateMixin {
  bool earthIsInteracting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const StarsView(
            fps: 60,
          ),
          Positioned(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  earthIsInteracting = !earthIsInteracting;
                });
              },
              child: !earthIsInteracting
                  ? Earth(
                      key: Key('Earth1'),
                      interative: false,
                    )
                  : Earth(
                      key: Key('Earth2'),
                      interative: true,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

//For Later redirecting we can use:
// body: GestureDetector(
//   onTap: () {
//     Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//       return EarthPage();
//     }));
//   }
