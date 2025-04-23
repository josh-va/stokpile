import 'package:flutter/material.dart';

class PositionAnimation extends StatelessWidget {
  const PositionAnimation({
    super.key,
    required this.xPositionAnimation,
    required this.yPositionAnimation,
    required this.widget,
  });

  final Animation<double> xPositionAnimation;
  final Animation<double> yPositionAnimation;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        xPositionAnimation,
        yPositionAnimation,
      ]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            xPositionAnimation.value,
            yPositionAnimation.value,
          ),
          child: widget,
        );
      },
    );
  }
}
