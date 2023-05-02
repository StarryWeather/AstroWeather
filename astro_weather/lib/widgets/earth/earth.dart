import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class Earth extends StatefulWidget {
  Earth({Key? key, required this.interactive}) : super(key: key);
  final bool interactive;
  @override
  State<Earth> createState() => _EarthState();
}

class _EarthState extends State<Earth> with SingleTickerProviderStateMixin {
  late Scene _scene;
  Object? _earth;
  
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 50000), vsync: this)
      ..addListener(() {
        if (!widget.interactive) {
          if (_earth != null) {
            _earth!.rotation.y = _controller.value * 360;
            _earth!.updateTransform();
            _scene.update();
          }
        }
      })
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSceneCreated(Scene scene) {
    //EDIT THIS FOR SIZING
    _scene = scene;
    _earth = Object(
        name: 'earth',
        scale: Vector3(10.0, 10.0, 10.0),
        fileName: 'assets/earth/earth.obj');
    _scene.world.add(_earth!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TweenAnimationBuilder<double>(
          duration: Duration(seconds: 0),
          curve: Curves.easeIn,
          tween: Tween(begin: 0, end: 1),
          builder: (context, animation, child) {
            return Opacity(
              opacity: animation,
              child: Cube(
                onObjectCreated: (object) {},
                onSceneCreated: _onSceneCreated,
                interactive: widget.interactive,
              ),
            );
          }),
    );
  }
}
