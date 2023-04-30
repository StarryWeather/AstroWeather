import 'package:astro_weather/models/rive_assets.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import '../../utils/rive_utils.dart';
import '../../widgets/SideMenu/SideMenuBrowsers.dart';
import '../../widgets/SideMenu/SideMenuInfoCard.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAssets selectedMenu = sideMenus.elementAt(1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: 288,
          height: double.infinity,
          color: Color(0xFF17203A),
          child: SafeArea(
            child: Column(
              children: [
                SideMenuInfoCard(name: 'Fake name', userType: 'User',),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                  child: Text("Browse".toUpperCase(),style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white70),),
                ),
                ...sideMenus.map(
                  (menu) => SideMenuBrowsers(
                    menu: menu,
                    riveonInit: (artboard) {
                      StateMachineController controller = RiveUtils.getRiveController(artboard, StateMachineName: menu.stateMachineName);
                      menu.input = controller.findSMI("active") as SMIBool;
                    },
                    press: () {
                      menu.input!.change(true);
                      Future.delayed(Duration(seconds: 1), () {
                        menu.input!.change(false);
                      });
                      setState(() {
                        selectedMenu = menu;
                      });
                    },
                    isActive: selectedMenu == menu,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                  child: Text("Other".toUpperCase(),style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white70),),
                ),
                ...sideMenu2.map(
                  (menu) => SideMenuBrowsers(
                    menu: menu,
                    riveonInit: (artboard) {
                      StateMachineController controller = RiveUtils.getRiveController(artboard, StateMachineName: menu.stateMachineName);
                      menu.input = controller.findSMI("active") as SMIBool;
                    },
                    press: () {
                      menu.input!.change(true);
                      Future.delayed(Duration(seconds: 1), () {
                        menu.input!.change(false);
                      });
                      setState(() {
                        selectedMenu = menu;
                      });
                    },
                    isActive: selectedMenu == menu,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}