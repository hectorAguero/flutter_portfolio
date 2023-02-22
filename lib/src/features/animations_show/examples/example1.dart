import 'dart:math' show pi;

import 'package:flutter/material.dart';

/// HomePage is a StatefulWidget that represents the main application page.
class ExampleOne extends StatefulWidget {
  /// Creates a HomePage widget.
  const ExampleOne({Key? key}) : super(key: key);

  @override
  State<ExampleOne> createState() => _ExampleOneState();
}

class _ExampleOneState extends State<ExampleOne>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  /*
  0.0 = 0 degrees
  0.5 = 180 degrees
  1.0 = 360 degrees
  */

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0.0, end: 2 * pi).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) => Transform(
            alignment: Alignment.center,
            // Alignment.center is the same that origin
            // So it's better to use alignment
            // origin: const Offset(50, 50),
            transform: Matrix4.identity()..rotateY(_animation.value),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 7,
                      spreadRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ]),
              child: const Icon(Icons.abc, size: 80),
            ),
          ),
        ),
      ),
    );
  }
}
