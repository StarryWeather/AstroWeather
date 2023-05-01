import 'package:flutter/material.dart';

class LocationInfo{
  String? id;
  String? Lat;
  String? Long;

  LocationInfo({
    required this.id,
    required this.Lat,
    required this.Long,//get number of locations saved for user from backend here
  });
}


class LocationData{
  String Lat;
  String Long;
  String cityName;
  String windSpeed;
  String windDirection;
  String humidity;
  String precip;
  String currentTemp;
  String feelsLikeTemp;
  String uv;
  String airQuality;
  
  String id;

  LocationData({
    required this.id,
    required this.Lat,
    required this.Long,
    required this.cityName,
    required this.windSpeed,
    required this.windDirection,
    required this.humidity,
    required this.precip,
    required this.currentTemp,
    required this.feelsLikeTemp,
    required this.uv,
    required this.airQuality,
  });
}