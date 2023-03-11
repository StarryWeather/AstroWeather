import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';



class LoginPage extends StatefulWidget{
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with TickerProviderStateMixin{
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: AnimatedBackground(
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
        child: Text('Hello')
          ),
      ),
    );
  }
}


