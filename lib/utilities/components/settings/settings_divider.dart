import 'package:flutter/material.dart';

class BottomBarDivider extends StatelessWidget {
  const BottomBarDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      endIndent: 24,
      indent: 24,
      color: Theme.of(context).dividerColor,
    );
  }
}
