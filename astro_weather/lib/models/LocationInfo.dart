import 'package:flutter/material.dart';

class LocationInfo{
  String? Lat;
  String? Long;

  LocationInfo({
    required this.Lat,
    required this.Long,
  });

  static List<LocationInfo> UserLocationList(){
    return[
      LocationInfo(Lat: '13.242', Long: '21.322')
    ];
  }

}
