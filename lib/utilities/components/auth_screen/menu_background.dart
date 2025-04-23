import 'package:flutter/material.dart';

class MenuBackground extends StatelessWidget {
  const MenuBackground({
    this.opacity,
    super.key,
  });

  final double? opacity;

  @override
  Widget build(BuildContext context) {
    final opacity = AlwaysStoppedAnimation(this.opacity ?? 1.0);
    return Image.asset(
      'assets/bg/menu_bg.png',
      opacity: opacity,
      fit: BoxFit.cover,
    );
  }
}
