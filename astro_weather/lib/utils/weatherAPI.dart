import 'package:flutter/material.dart';
import 'package:astro_weather/global.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/LocationInfo.dart';

Future<void> getGlobalLocation(lat, long) async {
  //calling API:
  var url = Uri.parse('https://api.weatherbit.io/v2.0/current?lat=' +
      lat.toString() +
      '&lon=' +
      long.toString() +
      '&key=dffbf9e2ee24421f8cb8e89f078664df');
  var response =
      await http.post(url, headers: {"Content-Type": "application/json"});

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

    //seting data to global:
    globals.latitude = lat;
    globals.longitude = long;
    globals.currentTemp = temps;
    globals.cloudCover = clouds;
    globals.weatherDescription = desc;
    globals.DayNight = dn;

    if (clouds > 75) {
      globals.cloudIndex = 2;
    } else if (clouds > 50) {
      globals.cloudIndex = 1;
    } else if (clouds > 25) {
      globals.cloudIndex = 0;
    } else {
      globals.cloudIndex = 0;
    }

    if(dn == "n")
    {
      globals.skyColor = LinearGradient(
          colors: [Color.fromARGB(255, 0, 0, 0), Color.fromARGB(255, 40, 48, 54)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        );
    }
    else if(globals.cloudIndex == 3)
    {
      globals.skyColor = LinearGradient(
          colors: [Color.fromARGB(255, 76, 114, 145), Color.fromARGB(255, 130, 130, 130)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        );
    } else if(globals.cloudIndex == 2)
    {
      globals.skyColor = LinearGradient(
          colors: [Color.fromARGB(255, 31, 98, 153), Color.fromARGB(255, 181, 181, 181)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        );
    } else if(globals.cloudIndex == 1)
    {
      globals.skyColor = LinearGradient(
          colors: [Color.fromARGB(255, 32, 126, 203), Color.fromARGB(255, 154, 154, 154)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        );
    } else if(globals.cloudIndex ==0)
    {
      globals.skyColor = LinearGradient(
          colors: [Colors.blue, Color.fromARGB(255, 189, 189, 189)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        );
    }

    //Crash:
  } else {
    debugPrint('WeatherAPI FAILED!');
  }
}

Future<LocationData> getLocationList(lat, long, id) async {
  //calling API:
  var url = Uri.parse('https://api.weatherbit.io/v2.0/current?lat=' +
      lat.toString() +
      '&lon=' +
      long.toString() +
      '&key=dffbf9e2ee24421f8cb8e89f078664df');
  var response =
      await http.post(url, headers: {"Content-Type": "application/json"});

  //getting response:
  if (response.statusCode == 200) {
    var responseJSON = json.decode(response.body);
    
    //getting data:
    var cityName = responseJSON['data'][0]['city_name'];
    var windSpeed = responseJSON['data'][0]['wind_spd'];
    var windDirection = responseJSON['data'][0]['wind_cdir'];
    var humidity = responseJSON['data'][0]['rh'];
    var precip = responseJSON['data'][0]['precip'];
    var currentTemp = responseJSON['data'][0]['temp'];
    currentTemp = ((currentTemp) * 1.8) + 32;
    currentTemp = currentTemp.round();
    currentTemp = currentTemp.toString();
    var feelsLikeTemp = responseJSON['data'][0]['app_temp'];
    feelsLikeTemp = ((feelsLikeTemp) * 1.8) + 32;
    feelsLikeTemp = feelsLikeTemp.round();
    feelsLikeTemp = feelsLikeTemp.toString();
    var uv = responseJSON['data'][0]['uv'];
    var airQuality = responseJSON['data'][0]['aqi'];

    return LocationData(
        id: id,
        Lat: lat,
        Long: long,
        cityName: cityName.toString(),
        windSpeed: windSpeed.toString(),
        windDirection: windDirection.toString(),
        humidity: humidity.toString(),
        precip: precip.toString(),
        currentTemp: currentTemp.toString(),
        feelsLikeTemp: feelsLikeTemp.toString(),
        uv: uv.toString(),
        airQuality: airQuality.toString());
    //Crash:
  } else {
    debugPrint('WeatherAPI FAILED!');
    return LocationData(
        id: "API FAIL!",
        Lat: "API FAIL!",
        Long: "API FAIL!",
        cityName: "API FAIL!",
        windSpeed: "API FAIL!",
        windDirection: "API FAIL!",
        humidity: "API FAIL!",
        precip: "API FAIL!",
        currentTemp: "API FAIL!",
        feelsLikeTemp: "API FAIL!",
        uv: "API FAIL!",
        airQuality: "API FAIL!");
  }
}


