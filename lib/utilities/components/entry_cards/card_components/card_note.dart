import 'package:flutter/material.dart';
import 'package:stokpile/utilities/components/entry_cards/card_components/card_constants.dart';

class CardNote extends StatelessWidget {
  const CardNote({
    super.key,
    required this.widgetOpacity,
    required this.note,
  });

  final double widgetOpacity;
  final String? note;

  @override
  Widget build(BuildContext context) {
    if (note != '' && note != null) {
      return Flexible(
        child: AnimatedOpacity(
          opacity: widgetOpacity,
          duration: animationDuration,
          child: Text(
            note!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }
}
