import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stokpile/utilities/components/entry_cards/card_components/card_constants.dart';
import 'package:stokpile/utilities/formatters/datetime_formatter.dart';

class CardTimestamp extends StatelessWidget {
  const CardTimestamp({
    super.key,
    required this.widgetOpacity,
    required this.timestamp,
  });

  final double widgetOpacity;
  final Timestamp timestamp;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widgetOpacity,
      duration: animationDuration,
      child: Text(
        timestampToFancyFormattedDate(timestamp: timestamp),
      ),
    );
  }
}
