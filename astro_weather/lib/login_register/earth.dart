import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class Earth extends StatefulWidget {
  Earth({Key? key, required this.interative}) : super(key: key);
  final bool interative;
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
        if (!widget.interative) {
          if (_earth != null) {
            _earth!.rotation.y = _controller.value * -360;
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
    if (widget.interative) {
      _scene.camera.position.z = 15;
    } else {
      _scene.camera.position.z = 15;
    }

    _earth = Object(
        name: 'earth',
        scale: Vector3(10.0, 10.0, 10.0),
        backfaceCulling: false,
        fileName: 'assets/earth/earth.obj'
        );

    _scene.world.add(_earth!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height /4,
      width: MediaQuery.of(context).size.width /4,
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
                interactive: widget.interative,
              ),
            );
          }),
    );
  }
}
