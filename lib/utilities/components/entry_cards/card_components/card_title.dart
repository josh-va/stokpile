import 'package:flutter/material.dart';
import 'package:stokpile/utilities/components/entry_cards/card_components/card_constants.dart';

class CardTitle extends StatelessWidget {
  const CardTitle({
    super.key,
    required this.widgetOpacity,
    required this.title,
  });

  final double widgetOpacity;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widgetOpacity,
      duration: animationDuration,
      child: Text(
        title,
        maxLines: 1,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
