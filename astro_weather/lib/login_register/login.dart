import 'package:flutter/material.dart';
import 'package:starsview/starsview.dart';
import 'earthsetter.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const StarsView(
            fps: 60,
          ),
          Column(
            children: [


              
              earthState(),
            ],
          ),
        ],
      ),
    );
  }
}
