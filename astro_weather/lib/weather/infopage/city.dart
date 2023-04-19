import 'package:flutter/material.dart';

class CityInfo extends StatefulWidget {
  final String location;
  const CityInfo(this.location, {Key? key}) : super(key: key);

  @override
  State<CityInfo> createState() => _CityInfoState();
}

class _CityInfoState extends State<CityInfo> {
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
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
            ),
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Container(
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(15),
            ),
            height: MediaQuery.of(context).size.height * 0.15,
          ),
        ],
      ),
    );
  }
}
