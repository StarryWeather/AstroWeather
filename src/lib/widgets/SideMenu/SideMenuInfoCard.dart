import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SideMenuInfoCard extends StatelessWidget {
  const SideMenuInfoCard({
    super.key, required this.name, required this.userType,
  });

  final String name, userType;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(CupertinoIcons.person, color: Colors.white,),
      ),
      title: Text(name, style: TextStyle(color: Colors.white),),
      subtitle: Text(userType, style: TextStyle(color: Colors.white),),
    );
  }
}