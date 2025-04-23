import 'package:flutter/material.dart';
import 'package:stokpile/constants/general.dart';

class AboutAppTile extends StatelessWidget {
  const AboutAppTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: const Text(
          '$appName\n$appVersion\nJosh Van Arsdale',
          textAlign: TextAlign.center,
        ),
        titleTextStyle: Theme.of(context).textTheme.bodyLarge);
  }
}
