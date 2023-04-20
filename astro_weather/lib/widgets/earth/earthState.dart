import 'dart:math';
import 'package:flutter/material.dart';

import 'earth.dart';

class earthState extends StatefulWidget {
  const earthState({super.key});
  @override
  State<earthState> createState() => earthStateState();
}

class earthStateState extends State<earthState> with TickerProviderStateMixin {
  bool earthIsInteracting = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: GestureDetector(
        onTap: () {
          setState(() {
            earthIsInteracting = !earthIsInteracting;
          });
        },
        child: !earthIsInteracting
            ? Earth(
                key: Key('Earth1'),
                interactive: false,
              )
            : Earth(
                key: Key('Earth2'),
                interactive: true,
              ),
      ),
    );
  }
}
