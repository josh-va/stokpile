import 'package:flutter/material.dart';
import 'package:stokpile/constants/cloud_storage_constants.dart';

class FabBodyIcon extends StatelessWidget {
  const FabBodyIcon({
    super.key,
    required this.type,
  });

  final String type;

  @override
  Widget build(BuildContext context) {
    if (type == saveEntryType) {
      return Icon(
        Icons.attach_money,
        color: Theme.of(context).colorScheme.onTertiaryFixedVariant,
      );
    } else {
      return Icon(
        Icons.money_off,
        color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
      );
    }
  }
}

Color fabColor(String type, BuildContext context) => type == saveEntryType
    ? Theme.of(context).colorScheme.tertiaryFixedDim
    : Theme.of(context).colorScheme.primaryFixedDim;
