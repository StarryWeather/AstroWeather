import 'package:astro_weather/weather/infopage/city.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

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
    sliderController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    var DevWidth = MediaQuery.of(context).size.width;
    var DevHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/weather/ground.jpg'),
            opacity: 0.87,
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
    );
  }
}
