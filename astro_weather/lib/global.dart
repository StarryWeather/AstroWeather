library my_prj.globals;
import 'models/LocationInfo.dart';

  //WeatherAPI:
  var latitude;
  var longitude;
  var currentTemp;
  var cloudCover;
  var weatherDescription;
  var cloudIndex;
  var DayNight;
  bool isRaining = false;
  bool isSnowing = false;
  //Google MapsAPI:
  var mapLat;
  var mapLon;
  //Login:
  var userAccessToken;
  var userName;
  //User's Saved Locations
  List<LocationInfo> StaticLocations = [];