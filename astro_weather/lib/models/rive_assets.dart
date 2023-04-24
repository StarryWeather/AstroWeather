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
    title: "Search"
  ),
  RiveAssets(
    "assets/RiveAssets/icons.riv",
    artboard: "CHAT",
    stateMachineName: "CHAT_Interactivity",
    title: "Help"
  ),

];

List<RiveAssets> bottonNavs = [
  RiveAssets(
    "assets/RiveAssets/icons.riv",
    artboard: "CHAT",
    stateMachineName: "CHAT_Interactivity",
    title: "Chat"
  ),
  RiveAssets("assets/RiveAssets/icons.riv",
    artboard: "SEARCH",
    stateMachineName: "SEARCH_Interactivity",
    title: "Search"
  ),
  RiveAssets("assets/RiveAssets/icons.riv",
    artboard: "TIMER",
    stateMachineName: "TIMER_Interactivity",
    title: "Chat"
  ),
  RiveAssets("assets/RiveAssets/icons.riv",
    artboard: "BELL",
    stateMachineName: "BELL_Interactivity",
    title: "Notifications"
  ),
  RiveAssets("assets/RiveAssets/icons.riv",
    artboard: "USER",
    stateMachineName: "USER_Interactivity",
    title: "Profile"
  ),
];