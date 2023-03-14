import 'package:flutter/material.dart';
import 'background.dart';
import 'package:page_transition/page_transition.dart';


class LoginPage extends StatefulWidget{
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SetBackground(),
    );
  }
}


