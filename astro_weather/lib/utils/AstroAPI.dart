import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:astro_weather/global.dart' as globals;
import 'package:http/http.dart' as http;


Future<void> jellyfish(lat, long) async {
  var code = ("54c0e856-effd-4386-9fa8-e30936d4569b:8e37e3b5728d880694f78e6168c03fe5f4a570da15eaf9b10baf18670bfad673f329eee1c04425bcbe5618bcbe9c80c17bf0904bca00c8480847d2e45cf0386439f278a1d048ecea61630268a3b047967c7d852c06e67773ea9ae729e1125f5da71fb9d2c64c84b4c508cd772112c1e9");
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  String authToken = stringToBase64.encode(code);
  
  var url = Uri.parse('https://api.astronomyapi.com/api/v2/studio/star-chart');
  var day = DateTime.now().day;
  var day2;
  var month= DateTime.now().month;
  var month2;
  if(month < 10)
  {
    month2 = "0"+month.toString();
  }
  else
  {
    month2 =  month.toString();
  }

  if(day < 10)
  {
    day2 = "0"+day.toString();
  }
  else
  {
    day2 = day.toString();
  }

  var data = {
    'observer': {
      'latitude': globals.latitude,
      'longitude': globals.longitude,
      'date': DateTime.now().year.toString() +
          "-" +
          month2 +
          "-" +
          day2
    },
    'view': {
      'type': "area",
      'parameters': {
        'position': {
          'equatorial': {'rightAscension': 20, 'declination': -20}
        },
      }
    }
  };
  var jsondata = jsonEncode(data);
  debugPrint(jsondata.toString());
  var response = await http.post(url,
      headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: "Basic "+ authToken},
      body: jsondata);
    print("Bad");
  if (response.statusCode == 200) {
    print("Really good");
    var responseJSON = json.decode(response.body);
    globals.StarsPng = responseJSON['data']['imageUrl'];
  } else {
    print(response.statusCode);
  }
}
