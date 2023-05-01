import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import '../../models/LocationInfo.dart';
import '../../widgets/InfoLocations/LocationsInfo_item.dart';
import '../InfoPage/map.dart';
import 'city.dart';
import 'package:astro_weather/global.dart' as globals;

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  CarouselSliderController sliderController = CarouselSliderController();

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
            child: Center(
              child: CarouselSlider.builder(
                onSlideStart: () {},
                onSlideChanged: (index) {},
                controller: sliderController,
                slideBuilder: (index) {
                  return LocationInfoItem(
                    numIndex: index,
                    OnDeleteItem: null, 
                  );
                },
                slideTransform: ZoomOutSlideTransform(),
                slideIndicator: CircularSlideIndicator(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * .015),
                  indicatorBackgroundColor: Colors.grey,
                  currentIndicatorColor: Colors.white,
                ),
                initialPage: 0,
                itemCount: globals.datalist.length,
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
            backgroundColor: Colors.blue[500],
            child: Text(
              "+",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'KdamThmorPro',
              ),
            ),
          ),
        ));
  }
}
