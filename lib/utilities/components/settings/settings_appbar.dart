import 'package:flutter/material.dart';
import 'package:stokpile/utilities/components/settings/settings_name_panel.dart';

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SettingsAppBar({
    super.key,
    required this.currentName,
  });

  final String currentName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Settings',
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: NamePanel(currentName),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(112);
}
