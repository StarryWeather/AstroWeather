import 'package:flutter/material.dart';
import '../../models/LocationInfo.dart';
import '../../utils/weatherAPI.dart';

class LocationInfoItem extends StatefulWidget {
  const LocationInfoItem(
      {super.key, required this.itemLocation, required this.OnDeleteItem});
  final itemLocation;
  final OnDeleteItem;

  @override
  State<LocationInfoItem> createState() =>
      _LocationInfoItemState(itemLocation, OnDeleteItem);
}

class _LocationInfoItemState extends State<LocationInfoItem> {
  final LocationInfo location;
  final onDelete;

  late String cityName,
      windSpeed,
      windDirection,
      humidity,
      precipitation,
      currentTemp,
      forecast,
      uv,
      airQuality;

  _LocationInfoItemState(this.location, this.onDelete);
  Future<void> dataGetter() async {
    await getLocation(location.Lat, location.Long);
  }

  @override
  void initState() {
    dataGetter();

    cityName = "Orlando";
    windSpeed = "9";
    windDirection = "NE";
    humidity = "52";
    precipitation = "dry";
    currentTemp = "78";
    forecast = "Cloudy";
    uv = "UV is Fake";
    airQuality = "horrible smell";

    super.initState();
  }

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
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
                child: Column(children: [
                  Center(
                    child: Text(
                      cityName,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'KdamThmorPro',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(155, 55, 55, 55),
                        border: Border.all(width: 3.0, color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('hi',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'KdamThmorPro',
                        ),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // return Container(
    //   decoration: BoxDecoration(
    //     color: Colors.grey,
    //     borderRadius: BorderRadius.circular(15),
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       // Location Name
    //       Container(
    //         decoration: BoxDecoration(
    //           color: Color.fromARGB(16, 190, 190, 190),
    //           borderRadius: BorderRadius.circular(15),
    //         ),
    //         height: MediaQuery.of(context).size.height * 0.30,
    //         alignment: Alignment.center,
    //         child: Text(
    //           cityName,
    //           style: TextStyle(
    //             fontSize: 40,
    //             fontWeight: FontWeight.normal,
    //             color: Color.fromARGB(255, 242, 242, 242),
    //             fontFamily: 'KdamThmorPro',
    //             shadows: [
    //               Shadow(
    //                 offset: Offset(2, 2),
    //                 blurRadius: 3,
    //                 color: Colors.black.withOpacity(0.5),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       SizedBox(height: MediaQuery.of(context).size.height * 0.05),
    //       Row(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Expanded(
    //             flex: 5,
    //             // Current Pertinent Weather Info
    //             child: Container(
    //               decoration: BoxDecoration(
    //                 color: Color.fromARGB(105, 255, 153, 0),
    //                 borderRadius: BorderRadius.circular(15),
    //               ),
    //               height: MediaQuery.of(context).size.height * 0.3,
    //               alignment: Alignment.center,
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     '$currentTemp\u00B0F',
    //                     style: TextStyle(
    //                       fontSize: 40,
    //                       fontWeight: FontWeight.normal,
    //                       color: Color.fromARGB(255, 242, 242, 242),
    //                       fontFamily: 'KdamThmorPro',
    //                       shadows: [
    //                         Shadow(
    //                           offset: Offset(2, 2),
    //                           blurRadius: 3,
    //                           color: Colors.black.withOpacity(0.5),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   Text(
    //                     forecast,
    //                     style: TextStyle(
    //                       fontSize: 25,
    //                       fontWeight: FontWeight.normal,
    //                       color: Color.fromARGB(255, 242, 242, 242),
    //                       fontFamily: 'KdamThmorPro',
    //                       shadows: [
    //                         Shadow(
    //                           offset: Offset(2, 2),
    //                           blurRadius: 3,
    //                           color: Colors.black.withOpacity(0.5),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   SizedBox(
    //                       height: MediaQuery.of(context).size.height * 0.03),
    //                   Text(
    //                     'High:',
    //                     style: TextStyle(
    //                       fontSize: 15,
    //                       fontWeight: FontWeight.normal,
    //                       color: Color.fromARGB(255, 242, 242, 242),
    //                       fontFamily: 'KdamThmorPro',
    //                       shadows: [
    //                         Shadow(
    //                           offset: Offset(2, 2),
    //                           blurRadius: 3,
    //                           color: Colors.black.withOpacity(0.5),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           // Check Stars of this location
    //           SizedBox(width: MediaQuery.of(context).size.width * 0.05),
    //           Expanded(
    //             flex: 2,
    //             child: GestureDetector(
    //               onTap: () {},
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                   image: DecorationImage(
    //                     image: AssetImage('assets/weather/observatory.jpg'),
    //                     opacity: 0.55,
    //                     fit: BoxFit.cover,
    //                   ),
    //                   borderRadius: BorderRadius.circular(15),
    //                 ),
    //                 height: MediaQuery.of(context).size.height * 0.3,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //       // Misc Information
    //       SizedBox(height: MediaQuery.of(context).size.height * 0.05),
    //       Container(
    //         decoration: BoxDecoration(
    //           color: Color.fromARGB(105, 255, 153, 0),
    //           borderRadius: BorderRadius.circular(15),
    //         ),
    //         height: MediaQuery.of(context).size.height * 0.15,
    //         alignment: Alignment.center,
    //         child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    //           SizedBox(width: MediaQuery.of(context).size.width * 0.05),
    //           Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    //             Image(
    //               image: AssetImage('assets/weather/wind.png'),
    //               height: MediaQuery.of(context).size.height * 0.06,
    //             ),
    //             Text(
    //               'mph',
    //               style: TextStyle(
    //                 fontSize: 15,
    //                 fontWeight: FontWeight.normal,
    //                 color: Color.fromARGB(255, 242, 242, 242),
    //                 fontFamily: 'KdamThmorPro',
    //                 shadows: [
    //                   Shadow(
    //                     offset: Offset(2, 2),
    //                     blurRadius: 3,
    //                     color: Colors.black.withOpacity(0.5),
    //                   ),
    //                 ],
    //               ),
    //             )
    //           ]),
    //           SizedBox(width: MediaQuery.of(context).size.width * 0.05),
    //         ]),
    //       ),
    //     ],
    //   ),
    // );
  }
}
