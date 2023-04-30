library my_prj.globals;
import 'models/LocationInfo.dart';

  //WeatherAPI:
  var latitude;
  var longitude;
  var currentTemp;
  var cloudCover;
  var weatherDescription;
  var cloudIndex;
  var skyColor;
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
  List<LocationInfo> StaticLocations = [
      //TEMP
      LocationInfo(Lat: '-16.975', Long: '23.322'),
      LocationInfo(Lat: '73.824', Long: '-55.598'),
      LocationInfo(Lat: '55.123', Long: '90.133'),
    ];
  List<LocationData> datalist = [];