import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';

class menuBar extends StatefulWidget {
  final double width;
  final double hight;
  const menuBar({required this.width, required this.hight, Key? key});
  
  @override
  State<menuBar> createState() => menuBarState(iconWidth: width, iconHight: hight);
}

class menuBarState extends State<menuBar> {
  final double iconWidth;
  final double iconHight;

  menuBarState({
    required this.iconWidth,
    required this.iconHight,
  });

  Artboard? _menuBars;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/riveAssets/menu_button.riv').then(
      (data) async {
        final file = RiveFile.import(data);
        final menuBar = file.mainArtboard;
        var controller = StateMachineController.fromArtboard(menuBar, 'clickState');
        if(controller != null) {
          menuBar.addController(controller);
        }        
        setState(() => _menuBars = menuBar);
      },
    ); 
  }
  
  Widget build(BuildContext context) {
    return SizedBox(
      width: iconWidth,
      height: iconHight,
      child: Rive(
        artboard: _menuBars!.instance(),
        ),
    );
  }
}