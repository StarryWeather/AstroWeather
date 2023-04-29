import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class sideMenuBtn extends StatelessWidget {
  const sideMenuBtn({
    Key? key, required this.press, required this.riveOnInit
  }): super(key: key);
  
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
    child: GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(left: 16, top: 16),
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0,2),
              blurRadius: 8,
            ),
          ]
        ),
        child: RiveAnimation.asset(
          "assets/RiveAssets/sideMenuButton.riv",
          onInit: riveOnInit,
          ),
        ),
      ),
    );
  }
} 