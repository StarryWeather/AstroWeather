import 'package:flutter/material.dart';


class Navbar extends StatefulWidget {
  const Navbar({super.key, required this.UserName});
  final String UserName;

  @override
  State<Navbar> createState() => NavBarState(UserName: UserName);
}

class NavBarState extends State<Navbar> {
  final String UserName;

  NavBarState({
    required this.UserName,
  });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: IconButton(
        icon: Icon(Icons.menu, color: Colors.white,),
        onPressed: () {
        },
      ),
    );
  }
}

