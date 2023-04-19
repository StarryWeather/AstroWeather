import 'package:astro_weather/weather/starspage/stars.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CityInfo extends StatefulWidget {
  final location;
  const CityInfo(this.location, {Key? key}) : super(key: key);

  @override
  State<CityInfo> createState() => _CityInfoState();
}

class _CityInfoState extends State<CityInfo> {
  // !!*** change per location parameters ***!!
  final cityName = "Orlando";
  final currentTemp = "78";
  final tempHigh = "82";
  final tempLow = "51";
  final tempRealFeel = "79";
  final forecast = "Cloudy";
  final humidity = "52";
  final wind = "9";
  final chanceRain = "33";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color.fromRGBO(83, 83, 83, 0.525),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Location Name
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(16, 190, 190, 190),
              borderRadius: BorderRadius.circular(15),
            ),
            height: MediaQuery.of(context).size.height * 0.10,
            alignment: Alignment.center,
            child: Text(
              cityName,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 242, 242, 242),
                fontFamily: 'KdamThmorPro',
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 3,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                // Current Pertinent Weather Info
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(105, 255, 153, 0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: MediaQuery.of(context).size.height * 0.3,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$currentTemp\u00B0F',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 242, 242, 242),
                          fontFamily: 'KdamThmorPro',
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        forecast,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 242, 242, 242),
                          fontFamily: 'KdamThmorPro',
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Text(
                        'High: $tempHigh\u00B0F    Low: $tempLow\u00B0F',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 242, 242, 242),
                          fontFamily: 'KdamThmorPro',
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Check Stars of this location
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      // !!***send location to star page***!!
                      MaterialPageRoute(builder: (context) => StarPage()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/weather/observatory.jpg'),
                        opacity: 0.55,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                ),
              ),
            ],
          ),
          // Misc Information
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(105, 255, 153, 0),
              borderRadius: BorderRadius.circular(15),
            ),
            height: MediaQuery.of(context).size.height * 0.15,
            alignment: Alignment.center,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  infoProperties: InfoProperties(
                    topLabelText: 'Humidity',
                    topLabelStyle: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 242, 242, 242),
                      fontFamily: 'KdamThmorPro',
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 3,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                    mainLabelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 242, 242, 242),
                      fontFamily: 'KdamThmorPro',
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 3,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                  size: 70,
                  customWidths: CustomSliderWidths(
                      trackWidth: 2, progressBarWidth: 5, handlerSize: 3),
                  customColors: CustomSliderColors(
                      progressBarColor: Color.fromARGB(255, 52, 125, 181),
                      trackColor: Color.fromARGB(255, 182, 206, 224)),
                ),
                min: 0,
                max: 100,
                initialValue: double.parse(humidity) * 1.0,
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image(
                  image: AssetImage('assets/weather/wind.png'),
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                Text(
                  '$wind mph',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 242, 242, 242),
                    fontFamily: 'KdamThmorPro',
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 3,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                )
              ]),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  infoProperties: InfoProperties(
                    topLabelText: 'Rain Chance',
                    topLabelStyle: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 242, 242, 242),
                      fontFamily: 'KdamThmorPro',
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 3,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                    mainLabelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 242, 242, 242),
                      fontFamily: 'KdamThmorPro',
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 3,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                  size: 70,
                  customWidths: CustomSliderWidths(
                      trackWidth: 2, progressBarWidth: 5, handlerSize: 3),
                  customColors: CustomSliderColors(
                      progressBarColor: Color.fromARGB(255, 52, 125, 181),
                      trackColor: Color.fromARGB(255, 182, 206, 224)),
                ),
                min: 0,
                max: 100,
                initialValue: double.parse(chanceRain) * 1.0,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
