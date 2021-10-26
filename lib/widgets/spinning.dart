import 'dart:math' as math;

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Spinning extends StatefulWidget {
  Widget child;
  Spinning({required this.child});
  @override
  _SpinningState createState() => _SpinningState();
}

class _SpinningState extends State<Spinning>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * math.pi,
                child: child,
              );
            },
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
