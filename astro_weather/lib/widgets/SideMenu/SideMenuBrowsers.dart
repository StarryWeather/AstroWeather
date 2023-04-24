import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../models/rive_assets.dart';

class SideMenuBrowsers extends StatelessWidget {
  const SideMenuBrowsers({
    super.key, required this.menu, required this.press, required this.riveonInit, required this.isActive,
  });

  final RiveAssets menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveonInit;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(color: Colors.white24, height: 1,),
        ),
        Stack(
          children: [
            isActive ? Positioned(
              height: 56,//edit!
              width: 288,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF6792FF),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
            ): SizedBox(),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: RiveAnimation.asset(
                  menu.src,
                  artboard: menu.artboard,
                  onInit: riveonInit,
                ),
              ),
              title: Text(menu.title,style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }
}
