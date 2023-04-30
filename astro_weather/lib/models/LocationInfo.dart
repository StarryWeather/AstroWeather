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
