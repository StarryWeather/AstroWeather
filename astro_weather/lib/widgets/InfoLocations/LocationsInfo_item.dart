import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../models/LocationInfo.dart';
import '../../utils/weatherAPI.dart';
import 'package:astro_weather/global.dart' as globals;

class LocationInfoItem extends StatefulWidget {
  const LocationInfoItem(
      {super.key, required this.numIndex, required this.OnDeleteItem});
  final numIndex;
  final OnDeleteItem;

  @override
  State<LocationInfoItem> createState() =>
      _LocationInfoItemState(numIndex, OnDeleteItem);
}

class _LocationInfoItemState extends State<LocationInfoItem> {
  final int numIndex;
  final onDelete;

  _LocationInfoItemState(this.numIndex, this.onDelete);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.05,
        bottom: MediaQuery.of(context).size.height * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
        left: MediaQuery.of(context).size.width * 0.05,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Color.fromARGB(160, 95, 95, 95),
          border: Border.all(width: 5.0, color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: deleteButton(),
            ),
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      globals.datalist[numIndex].cityName,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'KdamThmorPro',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ContainerMethod(
                              'Current Temperature: ${globals.datalist[numIndex].currentTemp}°',
                              'Feels Like: ${globals.datalist[numIndex].feelsLikeTemp}°'),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width *
                                      0.03)),
                          ContainerMethod(
                            'Humidity: ${globals.datalist[numIndex].humidity}%',
                            'Precipitation: ${globals.datalist[numIndex].precip} MM/HR',
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ContainerMethod(
                            'Wind Speed: ${globals.datalist[numIndex].windSpeed} MPS',
                            'Wind Direction: ${globals.datalist[numIndex].windDirection}',
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width *
                                      0.03)),
                          ContainerMethod(
                            'Air Quality: ${globals.datalist[numIndex].airQuality}/500',
                            'UV: ${globals.datalist[numIndex].uv}/11',
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton deleteButton() {
    return FloatingActionButton(
      onPressed: () async {
        debugPrint(globals.datalist[numIndex].id);
        // API LOGIN CALL
        var url = Uri.parse('http://astroweather.space/api/locations/');
        var data = {'_id': globals.datalist[numIndex].id};
        var jsonData = jsonEncode(data);
        var response = await http.delete(url,
            headers: {
              "Content-Type": "application/json",
              HttpHeaders.authorizationHeader:
                  "Bearer " + globals.userAccessToken
            },
            body: jsonData);

        if (response.statusCode == 200) {
          var responseJSON = json.decode(response.body);
          // add into staticlocations.
          debugPrint("holy crap its gone rip...");
          globals.datalist.removeAt(numIndex);
        } else {
          // false: display email/password invalid
          debugPrint('failedto delete');
        }
      },
      backgroundColor: Color.fromARGB(190, 244, 67, 54),
      child: Text(
        "X",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'KdamThmorPro',
        ),
      ),
    );
  }

  SizedBox ContainerMethod(String one, String two) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.4,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Color.fromARGB(155, 55, 55, 55),
          border: Border.all(width: 3.0, color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  one,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'KdamThmorPro',
                  ),
                ),
                Text(
                  two,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'KdamThmorPro',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
