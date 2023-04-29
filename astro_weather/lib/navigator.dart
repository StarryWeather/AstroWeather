import 'package:astro_weather/screens/loginpage/login.dart';
import 'package:astro_weather/screens/sideBar/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'models/sidebarBtn.dart';
import 'utils/rive_utils.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late SMIBool isSideBarClosed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          //Side Menu:
          Positioned(
            width: 288,
            height: MediaQuery.of(context).size.height,
            child: SideMenu(),
          ),
          
          Transform.translate(
            offset: Offset(288, 0),
            child: const LoginPage(),
          ),

          //Side Menu Button:
          sideMenuBtn(
            riveOnInit: (artboard) {
              StateMachineController controller = RiveUtils.getRiveController(
                artboard,
                StateMachineName: "State Machine"
              );
              isSideBarClosed = controller.findSMI("isOpen") as SMIBool;
              isSideBarClosed.value = true;
            },
            press: () {
              isSideBarClosed.value = !isSideBarClosed.value;
            },
          ),
        ],
      ),
    );
  }
}