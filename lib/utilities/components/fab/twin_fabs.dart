import 'package:flutter/material.dart';
import 'package:stokpile/constants/cloud_storage_constants.dart';
import 'package:stokpile/utilities/components/fab/main_fab.dart';

class TwinFabs extends StatelessWidget {
  const TwinFabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MainFab(type: saveEntryType),
        MainFab(type: spendEntryType),
      ],
    );
  }
}
