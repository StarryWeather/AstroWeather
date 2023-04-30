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
      LocationInfo(Lat: '13.242', Long: '21.322'),
      LocationInfo(Lat: '81.341', Long: '61.903'),
      LocationInfo(Lat: '55.123', Long: '90.133'),
    ];
  }


}
