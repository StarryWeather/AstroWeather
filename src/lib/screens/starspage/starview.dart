import 'package:astro_weather/screens/rootpage/root.dart';
import 'package:flutter/material.dart';
import 'package:astro_weather/global.dart' as globals;

class StarView extends StatefulWidget {
  const StarView({super.key});
  @override
  State<StarView> createState() => StarViewState();
}

class StarViewState extends State<StarView> {
 @override
  Widget build(BuildContext context) {
    return Container(child: Image.network(globals.StarsPng), color: Colors.black,);
  }
}