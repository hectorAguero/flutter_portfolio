import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

const double widthAndHeight = 100;

class ExampleThree extends StatefulWidget {
  const ExampleThree({Key? key}) : super(key: key);

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree>
    with TickerProviderStateMixin {
  late AnimationController _xController, _yController, _zController;
  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();
    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );

    _animation = Tween<double>(begin: 0, end: 2 * pi);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();
    _yController
      ..reset()
      ..repeat();
    _zController
      ..reset()
      ..repeat();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: widthAndHeight,
              width: double.infinity,
            ),
            AnimatedBuilder(
              animation: Listenable.merge([
                _xController,
                _yController,
                _zController,
              ]),
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateX(_animation.evaluate(_xController))
                    ..rotateY(_animation.evaluate(_yController))
                    ..rotateZ(_animation.evaluate(_zController)),
                  child: Stack(
                    children: [
                      Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.rotationY(pi / 2),
                        child: Container(
                          color: Colors.red,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),
                      Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.rotationY(-pi / 2),
                        child: Container(
                          color: Colors.blue,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),
                      // back
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..translate(vector.Vector3(0, 0, -widthAndHeight)),
                        child: Container(
                          color: Colors.purple,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ), // front
                      Container(
                        color: Colors.green,
                        width: widthAndHeight,
                        height: widthAndHeight,
                      ),
                      // top side
                      Transform(
                        alignment: Alignment.topCenter,
                        transform: Matrix4.rotationX(-pi / 2),
                        child: Container(
                          color: Colors.orange,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),
                      // bottom side
                      Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.rotationX(pi / 2),
                        child: Container(
                          color: Colors.brown,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
