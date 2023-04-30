import 'package:flutter/material.dart';

class LocationInfo{
  String? Lat;
  String? Long;

  LocationInfo({
    required this.Lat,
    required this.Long,//get number of locations saved for user from backend here
  });

  static List<LocationInfo> UserLocationList(){
    return[
      //get locations saved by user here
      LocationInfo(Lat: '-16.975', Long: '23.322'),
      LocationInfo(Lat: '73.824', Long: '-55.598'),
      LocationInfo(Lat: '55.123', Long: '90.133'),
    ];
  }
}


class LocationData{
  String cityName;
  String windSpeed;
  String windDirection;
  String humidity;
  String precip;
  String currentTemp;
  String feelsLikeTemp;
  String uv;
  String airQuality;

  LocationData({
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
  static List<LocationData> dataList(){
    return [];
  }
}