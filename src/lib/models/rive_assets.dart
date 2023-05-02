import 'package:rive/rive.dart';

class RiveAssets{
  final String src, artboard, stateMachineName, title;
  late SMIBool? input;

  RiveAssets(this.src,{
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.input
  });
  set setInput(SMIBool status){
    input = status;
  }
}

List<RiveAssets> sideMenus = [
  RiveAssets(
    "assets/RiveAssets/icons.riv",
    artboard: "LIKE/STAR",
    stateMachineName: "STAR_Interactivity",
    title: "Stars"
  ),
  RiveAssets(
    "assets/RiveAssets/icons.riv",
    artboard: "HOME",
    stateMachineName: "HOME_interactivity",
    title: "Earth"
  ),
  RiveAssets(
    "assets/RiveAssets/icons.riv",
    artboard: "SEARCH",
    stateMachineName: "SEARCH_Interactivity",
    title: "Info"
  ),
];
List<RiveAssets> sideMenu2 = [
    RiveAssets("assets/RiveAssets/icons.riv",
    artboard: "USER",
    stateMachineName: "USER_Interactivity",
    title: "Logout"
  ),
];