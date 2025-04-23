import 'package:flutter/material.dart';

class HistoryBoxHeader extends StatelessWidget {
  const HistoryBoxHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const FractionallySizedBox(
      widthFactor: 1,
      child: Padding(
        padding: EdgeInsets.only(bottom: 14),
        child: Text(
          'History',
          textAlign: TextAlign.center,
          textScaler: TextScaler.linear(1.5),
        ),
      ),
    );
  }
}
