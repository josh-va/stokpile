import 'package:flutter/material.dart';

class PrimaryBackground extends StatelessWidget {
  const PrimaryBackground({super.key});

  @override
  Widget build(BuildContext context) {
    late Image bg;
    if (Theme.of(context).colorScheme.brightness == Brightness.light) {
      bg = Image.asset(
        'assets/bg/main_bg.png',
        fit: BoxFit.cover,
      );
    } else {
      bg = Image.asset(
        'assets/bg/alt_main_bg.png',
        fit: BoxFit.cover,
      );
    }
    return bg;
  }
}
