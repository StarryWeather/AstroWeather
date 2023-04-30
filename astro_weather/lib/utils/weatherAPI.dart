import 'package:flutter/material.dart';
import 'package:astro_weather/global.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> getLocation(lat, long) async {
  //calling API:
  var url = Uri.parse('https://api.weatherbit.io/v2.0/current?lat=' + lat.toString() + '&lon=' + long.toString() + '&key=dffbf9e2ee24421f8cb8e89f078664df');
  var response = await http.post(url, headers: {"Content-Type": "application/json"});

  //getting response:
  if (response.statusCode == 200) {
    var responseJSON = json.decode(response.body);

    //getting data:
    var temps = responseJSON['data'][0]['temp'];
    temps = ((temps) * 1.8) + 32;
    temps = temps.round();
    var clouds = responseJSON['data'][0]['clouds'];
    var desc = responseJSON['data'][0]['weather']['description'];
    var dn = responseJSON['data'][0]['pod'];

    //seting data to global:
    globals.latitude = responseJSON['data'][0]['lat'];
    globals.longitude = responseJSON['data'][0]['lon'];
    globals.currentTemp = temps.toString();
    globals.cloudCover = clouds;
    globals.weatherDesc = desc;
    globals.DN = dn;

    if (clouds > 70) {
      globals.cloudIndex = 2;
    } else if (clouds > 50) {
      globals.cloudIndex = 1;
    } else {
      globals.cloudIndex = 0;
    }
  //Crash:
  } else {
    debugPrint('WeatherAPI FAILED!');
  }
}
