import 'package:flutter/material.dart';
import 'package:stokpile/utilities/components/settings/settings_about_tile.dart';
import 'package:stokpile/utilities/components/settings/settings_delete_all_button.dart';
import 'package:stokpile/utilities/components/settings/settings_divider.dart';
import 'package:stokpile/utilities/components/settings/settings_log_out_button.dart';

class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet(
    this.uid, {
    super.key,
  });
  final String uid;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: SizedBox(
        height: 200,
        child: ListView(children: [
          DeleteAllEntriesButton(uid),
          const BottomBarDivider(),
          const AboutAppTile(),
          const LogOutButton(),
        ]),
      ),
    );
  }
}
