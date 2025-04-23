import 'package:flutter/material.dart';
import 'package:stokpile/utilities/dialogs/logout_dialog.dart';
import 'package:stokpile/services/logout_blocs.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: const Text(
          'Log Out',
          textAlign: TextAlign.center,
        ),
        titleTextStyle: Theme.of(context).textTheme.labelLarge,
        onTap: () async {
          final shouldLogout = await showLogoutDialog(context);
          if (shouldLogout && context.mounted) {
            Navigator.of(context).pop();
            await logoutAllBlocs(context);
          }
        });
  }
}
