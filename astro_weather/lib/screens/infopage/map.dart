import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:astro_weather/global.dart' as globals;

class Map extends StatefulWidget{
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
   String googleApikey = "AIzaSyCcM9U9EWSRHgfbu4vhFn_MjmbjRHhrCxE";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(globals.latitude,globals.longitude); 
  String location = "Location Name:"; 
  var lat;
  var lon;
void updateState()
  {
    setState(() {
      this.lat = globals.mapLat;
      this.lon = globals.mapLon;
    });

  }

    @override
  void initState(){
    lat = globals.latitude;
    lon = globals.longitude;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar( 
             title: Text("Add Location"),
             backgroundColor: Colors.deepPurpleAccent,
          ),
          body: Stack(
            children:[

              GoogleMap( //Map widget from google_maps_flutter package
                  zoomGesturesEnabled: true, //enable Zoom in, out on map
                  initialCameraPosition: CameraPosition( //innital position in map
                    target: startLocation, //initial position
                    zoom: 10.0, //initial zoom level
                  ),
                  mapType: MapType.normal, //map type
                  onMapCreated: (controller) { //method called when map is created
                    setState(() {
                      mapController = controller; 
                    });
                  },
                  onCameraMove: (CameraPosition cameraPositiona) {
                      cameraPosition = cameraPositiona; //when map is dragging 
                  },
                  onTap: (latLng) {
                    globals.mapLat = double.parse(latLng.latitude.toString()).toStringAsFixed(3);
                    globals.mapLon = double.parse(latLng.longitude.toString()).toStringAsFixed(3);
                    updateState();
                  print('${latLng.latitude}, ${latLng.longitude}');
                  },
                  /*onCameraIdle: () async { //when map drag stops
                     List<Placemark> placemarks = await placemarkFromCoordinates(cameraPosition!.target.latitude, cameraPosition!.target.longitude);
                     setState(() { //get place name from lat and lang
                        location = placemarks.first.administrativeArea.toString() + ", " +  placemarks.first.street.toString();
                     });
                  },*/
             ),
            
             Positioned(  //widget to display location name
               bottom:0,
               child: Padding(
                   padding: EdgeInsets.all(20),
                    child: Center(
                      child: Card(
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(24))
                            ),
                            child: Text("Lat: " + lat.toString()+ "\nLong: "+ lon.toString(),
                            style: TextStyle(fontSize: 18),),
                            ),
                        ),
                    )
                       ),
                    ),
            ]
          )
       );
  }
}