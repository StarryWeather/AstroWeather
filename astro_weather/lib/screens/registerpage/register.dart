import 'package:astro_weather/screens/loginpage/login.dart';
import 'package:flutter/material.dart';
import 'package:starsview/starsview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../widgets/menuBars/menuBars.dart';
import '../rootpage/root.dart';

import '../../widgets/earth/earthState.dart';
import 'package:page_transition/page_transition.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool isEmailValid = true;
  bool isPasswordValid = true;
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Stack(
        children: [
          const StarsView(
            fps: 60,
          ),
          Column(
            children:  [
              Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03)),//page hight: 3%
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.height*0.01)),
                  menuBar(width: MediaQuery.of(context).size.height*0.05,hight: MediaQuery.of(context).size.height*0.05),//page hight: 5%
                ],
              ),              
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.03),//page hight: 3% top + 3% bottom 
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color.fromARGB(160, 95, 95, 95),
                    border: Border.all(width: 5.0, color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.05),
                    child: Column(
                      children: [
                        //welcome back,
                        const Text(
                          'Welcome to AstroWeather',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'KdamThmorPro',
                          ),
                        ),

                        const SizedBox(height: 16),

                        // email textfield
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            // set error style if email is invalid
                            errorText: isEmailValid ? null : 'Invalid Email',
                            errorBorder: isEmailValid
                                ? null
                                : OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        //password textfield
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            // set error style if password is invalid
                            errorText:
                                isPasswordValid ? null : 'Invalid Password',
                            errorBorder: isPasswordValid
                                ? null
                                : OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        //sign in button
                        Row(
                          children: [
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  // API LOGIN CALL
                                  var url = Uri.parse(
                                      'https://hidden-tor-21438.herokuapp.com/api/users/Register');
                                  var data = {
                                    'email': emailController.text,
                                    'password': passwordController.text
                                  };
                                  var jsonData = jsonEncode(data);
                                  var response = await http.post(url,
                                      headers: {
                                        "Content-Type": "application/json"
                                      },
                                      body: jsonData);
                                  // check if valid
                                  if (response.statusCode == 200) {
                                    // true: go to root
                                    debugPrint('Made it in here: pass');
                                    var responseJSON =
                                        json.decode(response.body);
                                    //var responseJSON = json.decode(response.body);
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.leftToRightPop,
                                        child: RootPage(
                                          accessToken:
                                              responseJSON['accessToken'],
                                        ),
                                        duration: Duration(milliseconds: 400),
                                      ),
                                    );
                                  } else {
                                    // false: display email/password invalid
                                    debugPrint('Made it in here: fail');
                                    isEmailValid = false;
                                    isPasswordValid = false;
                                  }
                                },
                                child: const Text('Register'),
                              ),
                            ),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Go Back'),
                              ),
                            ),
                          ],
                        ),
                        //sign in with google

                        //register
                      ],
                    ),
                  ),
                ),
              ),
              earthState(),
            ],
          ),
        ],
      ),
    );
  }
}
