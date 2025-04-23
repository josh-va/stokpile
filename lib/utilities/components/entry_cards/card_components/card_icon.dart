import 'package:flutter/material.dart';
import 'package:stokpile/enums/entry_type_enum.dart';
import 'package:stokpile/utilities/components/entry_cards/card_components/card_constants.dart';

class CardIcon extends StatelessWidget {
  const CardIcon({super.key, required this.widgetOpacity, required this.type});

  final double widgetOpacity;
  final EntryType type;

  @override
  Widget build(BuildContext context) {
    late Icon icon;
    if (type == EntryType.save) {
      icon = Icon(
        Icons.attach_money,
        color: Theme.of(context).colorScheme.onTertiaryContainer,
      );
    } else {
      icon = Icon(
        Icons.redeem,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      );
    }
    return AnimatedOpacity(
      duration: animationDuration,
      opacity: widgetOpacity,
      child: icon,
    );
  }
}
