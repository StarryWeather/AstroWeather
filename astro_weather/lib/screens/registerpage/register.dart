import 'package:flutter/material.dart';
import 'package:starsview/starsview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../rootpage/root.dart';
import '../../widgets/earth/earthState.dart';
import 'package:page_transition/page_transition.dart';
import 'package:email_validator/email_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool isEmailValid = true;
  bool isPasswordValid = true;
  late String passwordError = '';
  late String currPassword = '';
  late String currEmail = '';
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    if (currEmail != '') {
      emailController.text = currEmail;
    }
    final passwordController = TextEditingController();
    if (currPassword != '') {
      passwordController.text = currPassword;
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Stack(
        children: [
          const StarsView(
            fps: 60,
          ),
          Column(
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
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height *
                        0.05), //page hight: 5% + 5%
                    child: Column(
                      children: [
                        //welcome back,
                        const Text(
                          'Register for AstroWeather',
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
                          onChanged: (email) {
                            isEmailValid = EmailValidator.validate(email);
                            currEmail = email;
                          },
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
                          onChanged: (password) {
                            validatePassword(password);
                            currPassword = password;
                          },
                          decoration: InputDecoration(
                            hintText: 'Password',
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
                                  // API LOGIN CALL if valid password/email
                                  if (isPasswordValid == true &&
                                      isEmailValid == true) {
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
                                      var responseJSON =
                                          json.decode(response.body);
                                      //var responseJSON = json.decode(response.body);
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type:
                                              PageTransitionType.leftToRightPop,
                                          child: RootPage(
                                            accessToken:
                                                responseJSON['accessToken'],
                                          ),
                                          duration: Duration(milliseconds: 400),
                                        ),
                                      );
                                    } else {
                                      // false: display email/password invalid
                                      isEmailValid = false;
                                      isPasswordValid = false;
                                    }
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
