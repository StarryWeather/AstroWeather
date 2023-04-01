import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class Rocket extends StatefulWidget {
  const Rocket({super.key});
  @override
  State<Rocket> createState() => _RocketState();
}

class _RocketState extends State<Rocket> with SingleTickerProviderStateMixin {
  late Scene _scene;
  Object? _rocket;
  
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 50000), vsync: this)
      ..addListener(() {
          if (_rocket != null) {
            _rocket!.rotation.y = _controller.value * -360;
            _rocket!.updateTransform();
            _scene.update();
          }
      })
      ..repeat();
  }

  void _onSceneCreated(Scene scene) {
    _scene = scene;
    _scene.camera.zoom = 10;
    _rocket = Object(
      name: 'rocket',
      fileName: "assets/rocket/rocket.obj");
    _scene.world.add(_rocket!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      width: MediaQuery.of(context).size.width,
      child: Cube(
        onObjectCreated: (Object) {},
        onSceneCreated: _onSceneCreated,
      ),
    );
  }
}
