import 'package:flutter/material.dart';

class RotationAnimation extends StatelessWidget {
  const RotationAnimation({
    super.key,
    required this.rotationAnimation,
    required this.pivotPoint,
    required this.widget,
  });

  final Animation<double> rotationAnimation;
  final Alignment pivotPoint;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: rotationAnimation,
      builder: (context, child) {
        return Transform.rotate(
          alignment: pivotPoint,
          angle: rotationAnimation.value,
          child: widget,
        );
      },
    );
  }
}
