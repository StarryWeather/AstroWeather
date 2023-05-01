import 'dart:io';

import 'package:astro_weather/screens/registerpage/password.dart';
import 'package:astro_weather/utils/rive_utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rive/rive.dart';
import 'package:starsview/starsview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/LocationInfo.dart';
import '../../models/sidebarBtn.dart';
import '../../utils/weatherAPI.dart';
import '../registerpage/register.dart';
import '../rootpage/root.dart';
import 'package:page_transition/page_transition.dart';
import '../../widgets/earth/earthState.dart';
import 'package:astro_weather/global.dart' as globals;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool isEmailValid = true;
  bool isPasswordValid = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    late SMIBool isSideMenuClosed;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Stack(
        children: [
          const StarsView(
            fps: 60,
          ),
          Column(
            children: [
              SizedBox(
                height: 12,
              ),
              LoginBuilder(context),
              earthState(),
            ],
          ),
        ],
      ),
    );
  }

  Container LoginBuilder(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width *
          0.03), //page hight: 3% top + 3% bottom
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
              MediaQuery.of(context).size.height * 0.05), //page hight: 5% + 5%
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
              emailTextField(emailController),
              const SizedBox(height: 16),
              passwordTextField(passwordController),
              const SizedBox(height: 16),
              forgotPW(),
              const SizedBox(height: 16),
              SignInButton(emailController, passwordController, context),
            ],
          ),
        ),
      ),
    );
  }

  Row SignInButton(TextEditingController emailController,
      TextEditingController passwordController, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              // API LOGIN CALL
              var url = Uri.parse('http://astroweather.space/api/users/login');
              var data = {
                'email': emailController.text,
                'password': passwordController.text
              };
              var jsonData = jsonEncode(data);
              var response = await http.post(url,
                  headers: {"Content-Type": "application/json"},
                  body: jsonData);

              if (response.statusCode == 200) {
                var responseJSON = json.decode(response.body);
                globals.userAccessToken = responseJSON['accessToken'];

                await getData();

                await pullLocations();
                //turn this into an api call

                for (LocationInfo i in globals.OldLocations) {
                  globals.datalist.add(await getLocationList(i.Lat, i.Long));
                }

                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: RootPage(),
                    duration: Duration(milliseconds: 400),
                  ),
                );
              } else {
                // false: display email/password invalid
                debugPrint('Login Failed!');
                isEmailValid = false;
                isPasswordValid = false;
              }
            },
            child: const Text('Login'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: RegisterPage(),
                  duration: Duration(milliseconds: 400),
                ),
              );
            },
            child: const Text('Register'),
          ),
        ),
      ],
    );
  }

  Row forgotPW() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.bottomToTop,
                child: PasswordPage(),
                duration: Duration(milliseconds: 400),
              ),
            );
          },
          child: Text('Forgot Password'),
        ),
      ],
    );
  }

  TextField passwordTextField(TextEditingController passwordController) {
    return TextField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        // set error style if password is invalid
        errorText: isPasswordValid ? null : 'Invalid Password',
        errorBorder: isPasswordValid
            ? null
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.red),
              ),
      ),
    );
  }

  TextField emailTextField(TextEditingController emailController) {
    return TextField(
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
    );
  }
}

Future<void> getData() async {
  await Geolocator.checkPermission();
  await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low);
  await getGlobalLocation(
      position.latitude.toString(), position.longitude.toString());
}

Future<void> pullLocations() async {
  var url = Uri.parse('http://astroweather.space/api/locations/');
  var response = await http.get(
    url,
    headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + globals.userAccessToken
    },
  );

  if (response.statusCode == 200) {
    print("PARTY TIME!!!!");
    var responseJSON = json.decode(response.body);
    if(responseJSON == null)
    {
      return;
    }
    for(int x = 0; x < responseJSON['savedLocations'].length; x++)
    {
      print("Arigato!!!!");
      globals.OldLocations.add(LocationInfo(Lat: responseJSON['savedLocations'][x]['latitude'].toString(), Long: responseJSON['savedLocations'][x]['longitude'].toString()));
    }
  
  } else {
    debugPrint(json.decode(response.body));
  }
}
