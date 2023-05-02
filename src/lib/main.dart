import 'package:astro_weather/screens/infopage/info.dart';
import 'package:astro_weather/screens/loginpage/login.dart';
import 'package:astro_weather/screens/registerpage/reset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/navigator.dart';

import 'screens/rootpage/root.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AstroWeather',
      home: LoginPage(),
    );
  }
}