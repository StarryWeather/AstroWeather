import 'package:astro_weather/screens/infopage/city.dart';
import 'package:astro_weather/screens/rootpage/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:astro_weather/global.dart' as globals;
import 'package:page_transition/page_transition.dart';
import '../infopage/map.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final List<String> locations = [
    "New York",
    "Chicago",
    "Las Vegas",
    "Miami",
    "Hong Kong",
    "Paris",
    "Madrid",
  ];

  late CarouselSliderController sliderController;
  @override
  void initState() {
    super.initState();
    // !!***pull locations here***!!
    sliderController = CarouselSliderController();
  }

  var temp;
  var weatherDesc;
  void updateState()
  {
    setState(() {
      this.temp = globals.currentTemp;
      this.weatherDesc = globals.weatherDesc;
    });

  }
  @override
  Widget build(BuildContext context) {
    var DevWidth = MediaQuery.of(context).size.width;
    var DevHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy > 0) {
          Navigator.pop(context);
        }
      },
      child : Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/weather/ground.jpg'),
            opacity: 0.84,
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(DevWidth * .125, DevHeight * .15,
              DevWidth * .125, DevWidth * .20),
          child: Center(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  Navigator.pop(context);
                }
              },
              child: CarouselSlider.builder(
                onSlideStart: () {
                  // !!***pull first location here***!!
                },
                onSlideChanged: (index) {
                  // !!***pull location info here***!!
                },
                unlimitedMode: true,
                controller: sliderController,
                slideBuilder: (index) {
                  return CityInfo(locations[index]);
                },
                slideTransform: ZoomOutSlideTransform(),
                slideIndicator: CircularSlideIndicator(
                  padding: EdgeInsets.only(bottom: DevHeight * .01),
                  indicatorBackgroundColor:
                      Color.fromRGBO(255, 255, 255, 0.138),
                  currentIndicatorColor: Color.fromRGBO(255, 255, 255, 0.622),
                  indicatorBorderColor: Color.fromRGBO(82, 82, 82, 0.137),
                ),
                itemCount: locations.length,
                initialPage: 0,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: Map(),
                                        duration: Duration(milliseconds: 400),
                                      ),
                                    );
            // !!*** create new location ***!!
          },
          backgroundColor: Color.fromARGB(255, 52, 125, 181),
          child: Icon(Icons.add)),
    ),
    );
  }
}
