import 'package:flutter/material.dart';
import 'package:stokpile/utilities/dialogs/dialog_text.dart';
import 'package:stokpile/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context, {
  required String errorText,
}) {
  return showGenericDialog<void>(
    context: context,
    title: errorTitle,
    content: Text(errorText),
    optionsBuilder: () => {
      dialogOk: null,
    },
  );
}
