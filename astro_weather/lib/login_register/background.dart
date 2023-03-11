import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';


class background extends State with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
            spawnMaxRadius: 50,
            spawnMinSpeed: 10.00,
            particleCount: 68,
            spawnMaxSpeed: 50,
            minOpacity: 0.3,
            spawnOpacity: 0.4,
            baseColor: Colors.black,
          ),
        ),
        vsync: this,
        child: Text('Hello'),
      ),
    );
  }

}