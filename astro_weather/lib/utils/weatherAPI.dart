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
    var lat = responseJSON['data'][0]['lat'];
    var long = responseJSON['data'][0]['lon'];
    var temps = responseJSON['data'][0]['temp'];
    temps = ((temps) * 1.8) + 32;
    temps = temps.round();
    temps = temps.toString();
    var clouds = responseJSON['data'][0]['clouds'];
    var desc = responseJSON['data'][0]['weather']['description'];
    var dn = responseJSON['data'][0]['pod'];
    var cityName = responseJSON['data'][0]['city_name'];
    var windSpeed = responseJSON['data'][0]['wind_spd'];
    var windDirection = responseJSON['data'][0]['wind_cdir'];
    var humidity = responseJSON['data'][0]['rh'];
    var precip = responseJSON['data'][0]['precip'];
    var feelsLikeTemp = responseJSON['data'][0]['app_temp'];
    var uv = responseJSON['data'][0]['uv'];
    var airQuality = responseJSON['data'][0]['aqi'];

    //seting data to global:
    globals.latitude = lat;
    globals.longitude = long;
    globals.currentTemp = temps;
    globals.cloudCover = clouds;
    globals.weatherDescription = desc;
    globals.DayNight = dn;
    

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