import 'package:flutter/material.dart';
import 'package:stokpile/utilities/dialogs/dialog_text.dart';
import 'package:stokpile/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: logoutTitle,
    content: const Text(logoutBody),
    optionsBuilder: () => {
      dialogCancel: false,
      dialogLogout: true,
    },
  ).then((value) => value ?? false);
}
