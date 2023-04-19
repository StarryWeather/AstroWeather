import 'package:astro_weather/screens/loginpage/login.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class EricTest extends StatefulWidget {
  const EricTest({super.key});
  @override
  State<EricTest> createState() => EricTestState();
}

class EricTestState extends State<EricTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber.shade500,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Hey whats up guys its owen here"),
              Text("Back at it again with another test page"),
              Text("I made buttons to get here pretty neat right?"),
              Text("Alright ill make a button to go back"),
              GestureDetector(
                onTap: () {
                  //print("ButtonClicked");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple,
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text("Back"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
