import 'package:flutter/material.dart';
import 'package:stokpile/utilities/dialogs/dialog_text.dart';
import 'package:stokpile/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteAllDialog(
  BuildContext context,
) {
  return showGenericDialog<bool>(
    context: context,
    title: deleteAllTitle,
    content: const Text(deleteAllBody),
    optionsBuilder: () => {
      dialogNo: false,
      deleteAllConfirm: true,
    },
  ).then((value) => value ?? false);
}
