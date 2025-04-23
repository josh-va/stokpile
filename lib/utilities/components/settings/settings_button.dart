import 'package:flutter/material.dart';
import 'package:stokpile/utilities/transitions/slide_in_transition.dart';
import 'package:stokpile/views/auth/primary_flow/settings_view.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: 48,
        onPressed: () {
          Navigator.of(context).push(SlideInRoute(
            widget: const SettingsView(),
            x: 0.0,
            y: 1.0,
          ));
        },
        icon: const Icon(
          Icons.settings,
        ));
  }
}
