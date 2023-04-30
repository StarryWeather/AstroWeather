import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import '../../models/LocationInfo.dart';
import '../InfoPage/map.dart';
import 'city.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final locations = LocationInfo.UserLocationList();
  List<LocationInfo> foundlocations = [];

  CarouselSliderController sliderController = CarouselSliderController();

  @override
  void initState() {
    foundlocations = locations;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy > 0) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/weather/ground.jpg'),
              opacity: 0.84,
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
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

                  },
                  unlimitedMode: true,
                  controller: sliderController,
                  slideBuilder: (index) {
                    return CityInfo(locations[index]);
                  },
                  slideTransform: ZoomOutSlideTransform(),
                  slideIndicator: CircularSlideIndicator(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .01),
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
