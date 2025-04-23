import 'package:flutter/material.dart';
import 'package:stokpile/utilities/dialogs/dialog_text.dart';
import 'package:stokpile/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: deleteTitle,
    content: const Text(deleteBody),
    optionsBuilder: () => {
      dialogNo: false,
      dialogDelete: true,
    },
  ).then((value) => value ?? false);
}
