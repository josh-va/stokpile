import 'package:flutter/material.dart';

class ScaleAnimation extends StatelessWidget {
  const ScaleAnimation({
    super.key,
    required this.scaleAnimation,
    required this.widget,
  });

  final Animation<double> scaleAnimation;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: scaleAnimation.value,
          child: widget,
        );
      },
    );
  }
}
