import 'package:astro_weather/screens/registerpage/reset.dart';
import 'package:flutter/material.dart';
import 'package:starsview/starsview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../rootpage/root.dart';
import '../../widgets/earth/earthState.dart';
import 'package:page_transition/page_transition.dart';
import 'package:email_validator/email_validator.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});
  @override
  State<PasswordPage> createState() => PasswordPageState();
}

class PasswordPageState extends State<PasswordPage> {
  bool isEmailValid = true;
  late String currEmail = '';
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (currEmail != '') {
      emailController.text = currEmail;
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
                child: Container(
                  constraints: BoxConstraints.tightForFinite(width: 700),
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
                          forgotPWText(),
                          const SizedBox(height: 16),
                          ForgotPWEmail(),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const SizedBox(width: 16),
                              Expanded(
                                child: SendEmailButton(context),
                              ),
                              Expanded(
                                child: GoBackButton(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              earthState(),
              //SecondEarth(),
            ],
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

  Text forgotPWText() {
    return const Text(
      'Forgot Password?',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'KdamThmorPro',
      ),
    );
  }

  OutlinedButton GoBackButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('Go Back'),
    );
  }

  ElevatedButton SendEmailButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // API LOGIN CALL if valid password/email
        if (isEmailValid == true) {
          var url = Uri.parse('http://astroweather.space/api/users/reset');
          var data = {
            'email': emailController.text,
          };
          var jsonData = jsonEncode(data);
          var response = await http.post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData);
          // check if valid
          if (response.statusCode == 201) {
            // true: go to root
            var responseJSON = json.decode(response.body);
            //var responseJSON = json.decode(response.body);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResetPage()),
            );
          } else {
            // false: display email/password invalid
            isEmailValid = false;
          }
        }
      },
      child: const Text('Send Email'),
    );
  }

  TextField ForgotPWEmail() {
    return TextField(
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
    );
  }
}
