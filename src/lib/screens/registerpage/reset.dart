import 'dart:io';

import 'package:astro_weather/screens/loginpage/login.dart';
import 'package:flutter/material.dart';
import 'package:starsview/starsview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../rootpage/root.dart';
import '../../widgets/earth/earthState.dart';
import 'package:page_transition/page_transition.dart';
import 'package:email_validator/email_validator.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({super.key});
  @override
  State<ResetPage> createState() => ResetPageState();
}

class ResetPageState extends State<ResetPage> {
  bool isPasswordValid = true;
  late String passwordError = '';
  late String verification = '';
  late String newPassword = '';
  final verificationController = TextEditingController();
  final newpassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (newPassword != '') {
      newpassController.text = newPassword;
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Stack(
        children: [
          const StarsView(
            fps: 60,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height *
                      0.03), //page hight: 3% top + 3% bottom
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color.fromARGB(160, 95, 95, 95),
                      border: Border.all(width: 5.0, color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height *
                              0.05), //page hight: 5% + 5%
                      child: Column(
                        children: [
                          //welcome back,
                          const Text(
                            'Reset Password',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'KdamThmorPro',
                            ),
                          ),

                          const SizedBox(height: 16),
                          TextField(
                            controller: verificationController,
                            obscureText: true,
                            onChanged: (code) {
                              verification = code;
                            },
                            decoration: InputDecoration(
                              hintText: 'Input Verification Code',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          //password textfield
                          TextField(
                            controller: newpassController,
                            obscureText: true,
                            onChanged: (password) {
                              validatePassword(password);
                              newPassword = password;
                            },
                            decoration: InputDecoration(
                              hintText: 'New Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              // set error style if password is invalid
                              errorText: isPasswordValid ? null : passwordError,
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
                                        'http://astroweather.space/api/users/resetPassword');
                                    var data = {
                                      'newPassword': newpassController.text,
                                    };
                                    var jsonData = jsonEncode(data);
                                    var response = await http.post(url,
                                        headers: {
                                          "Content-Type": "application/json",
                                          HttpHeaders.authorizationHeader:
                                              "Bearer " +
                                                  verificationController.text,
                                        },
                                        body: jsonData);

                                    if (response.statusCode == 200) {
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                      );
                                    } else {
                                      // false: display email/password invalid
                                      debugPrint('Password Update Failed!');
                                    }
                                  },
                                  child: const Text('Update Password'),
                                ),
                              ),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                    );
                                  },
                                  child: const Text('Go Back'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //earthState(),
                SecondEarth(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox SecondEarth() {
    return SizedBox(
      child: Image.asset(
        'assets/weather/earth_spin.gif',
        color: Color.fromARGB(80, 0, 0, 0),
        colorBlendMode: BlendMode.srcATop,
        width: 900.0,
        height: 900.0,
        fit: BoxFit.cover,
      ),
    );
  }

  void validatePassword(String password) {
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigit = password.contains(RegExp(r'\d'));
    bool hasSpecialChar = password.contains(RegExp(r'[!@#\$&*~]'));
    bool hasMinLength = password.length >= 8;

    isPasswordValid = hasUppercase &&
        hasLowercase &&
        hasDigit &&
        hasSpecialChar &&
        hasMinLength;

    passwordError = '';
    List<String> errorMessages = [];

    if (!hasUppercase) {
      errorMessages.add('Must have an uppercase letter');
    }

    if (!hasLowercase) {
      errorMessages.add('Must have a lowercase letter');
    }

    if (!hasDigit) {
      errorMessages.add('Must have a digit');
    }

    if (!hasSpecialChar) {
      errorMessages.add('Must have a special character');
    }

    if (!hasMinLength) {
      errorMessages.add('Must have minimum 8 characters');
    }

    if (errorMessages.isNotEmpty) {
      passwordError = errorMessages.join('\n');
    }
  }
}
