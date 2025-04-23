import 'package:flutter/material.dart';
import 'package:stokpile/utilities/components/entry_cards/card_components/card_constants.dart';

class CardValue extends StatelessWidget {
  const CardValue({
    super.key,
    required this.widgetOpacity,
    required this.value,
  });

  final double widgetOpacity;
  final num value;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widgetOpacity,
      duration: animationDuration,
      child: Text(
        '\$${value.toStringAsFixed(2)}',
      ),
    );
  }
}
