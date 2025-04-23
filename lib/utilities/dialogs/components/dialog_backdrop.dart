import 'dart:ui';

import 'package:flutter/material.dart';

class DialogBackdrop extends StatelessWidget {
  const DialogBackdrop(
      {super.key, required this.animation, required this.child});
  final Animation<double> animation;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 2 * animation.value,
        sigmaY: 2 * animation.value,
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(
            0,
            0.01,
          ),
          end: Offset.zero,
        ).animate(animation),
        transformHitTests: false,
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeIn,
          ),
          child: child,
        ),
      ),
    );
  }
}
