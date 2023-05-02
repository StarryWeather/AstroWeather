import 'dart:convert';
import 'dart:io';

import 'package:astro_weather/models/LocationInfo.dart';
import 'package:astro_weather/utils/weatherAPI.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:astro_weather/global.dart' as globals;
import 'package:http/http.dart' as http;

class ourMaps extends StatefulWidget {
  final onAddItem;
  const ourMaps({super.key, required this.onAddItem});
  @override
  _ourMapsState createState() => _ourMapsState(onAddItem);
}

class _ourMapsState extends State<ourMaps> {
  final onAdd;
  _ourMapsState(this.onAdd);
  String googleApikey = "AIzaSyCcM9U9EWSRHgfbu4vhFn_MjmbjRHhrCxE";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(globals.latitude, globals.longitude);
  String location = "Location Name:";
  var lat;
  var lon;
  void updateState() {
    setState(() {
      this.lat = globals.mapLat;
      this.lon = globals.mapLon;
    });
  }

  @override
  void initState() {
    lat = globals.latitude;
    lon = globals.longitude;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Location"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Stack(
        children: [
          ourMap(),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.5,
            left: MediaQuery.of(context).size.width * 0.5,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(37, 255, 255, 255),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        addButton(onAdd: onAdd),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Lat: $lat\nLong: $lon",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  GoogleMap ourMap() {
    return GoogleMap(
      //Map widget from google_maps_flutter package
      zoomGesturesEnabled: true, //enable Zoom in, out on map
      initialCameraPosition: CameraPosition(
        //innital position in map
        target: startLocation, //initial position
        zoom: 10.0, //initial zoom level
      ),
      mapType: MapType.normal, //map type
      onMapCreated: (controller) {
        //method called when map is created
        setState(() {
          mapController = controller;
        });
      },
      onCameraMove: (CameraPosition cameraPositiona) {
        cameraPosition = cameraPositiona; //when map is dragging
      },
      onTap: (latLng) async {
        globals.mapLat =
            double.parse(await latLng.latitude.toString()).toStringAsFixed(3);
        globals.mapLon =
            double.parse(await latLng.longitude.toString()).toStringAsFixed(3);
        updateState();

        print('${latLng.latitude}, ${latLng.longitude}');
      },
      /*onCameraIdle: () async { //when map drag stops
                   List<Placemark> placemarks = await placemarkFromCoordinates(cameraPosition!.target.latitude, cameraPosition!.target.longitude);
                   setState(() { //get place name from lat and lang
                      location = placemarks.first.administrativeArea.toString() + ", " +  placemarks.first.street.toString();
                   });
                },*/
    );
  }
}

class addButton extends StatelessWidget {
  final onAdd;
  const addButton({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        // API LOGIN CALL
        var url = Uri.parse('http://astroweather.space/api/locations/');
        var data = {'lat': globals.mapLat, 'long': globals.mapLon};
        var jsonData = jsonEncode(data);
        var response = await http.post(url,
            headers: {
              "Content-Type": "application/json",
              HttpHeaders.authorizationHeader:
                  "Bearer " + globals.userAccessToken
            },
            body: jsonData);

        if (response.statusCode == 201 || response.statusCode == 204) {
          var responseJSON = json.decode(response.body);
          onAdd(await getLocationList(
              globals.mapLat,
              globals.mapLon,
              responseJSON['savedLocations']
                  [responseJSON['savedLocations'].length - 1]['_id']));
        } else {
          debugPrint('failedto add');
        }
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      child: Icon(
        Icons.add,
        size: 60.0,
        color: Color.fromARGB(255, 255, 0, 0),
      ),
    );
  }
}
