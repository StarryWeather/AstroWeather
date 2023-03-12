import 'dart:math';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:starsview/starsview.dart';

class SetBackground extends StatefulWidget {
  const SetBackground({super.key});
  @override
  State<SetBackground> createState() => SetBackgroundState();
}

class SetBackgroundState extends State<SetBackground> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Stack(
          children: [

          // const StarsView(
          //   fps: 60,
          // )

          // Center(child: RotatingEarth())



        AnimatedBackground (
          behaviour: RandomParticleBehaviour(
            options: const ParticleOptions(
              spawnMaxRadius: 10,
              spawnMinRadius: 1,
              spawnMinSpeed: 0.50,
              particleCount: 150,
              spawnMaxSpeed: 25,
              spawnOpacity: 0.5,
              minOpacity: 0.1,
              maxOpacity: 0.9,
              image: Image(image: AssetImage('../../assets/images/google.png')),
            ),
          ),
          vsync: this,
          child: Center(
            child: const Text('Hello'),
          )
        ),
           
          ],
        ),
      );
  }
}




class RotatingEarth extends StatefulWidget {
  @override
  _RotatingEarthState createState() => _RotatingEarthState();
}

class _RotatingEarthState extends State<RotatingEarth> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<AssetImage> earth = [
    AssetImage('../../assets/images/google.png'),
  ];
  
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 100),
    )..repeat();
    _controller.addListener(() {
      setState(() {
        _currentIndex = (_currentIndex + 1) % earth.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _controller.value * 2 * pi,
      child: Image(image: earth[_currentIndex]),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}