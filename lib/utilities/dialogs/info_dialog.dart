import 'package:flutter/material.dart';
import 'package:stokpile/utilities/dialogs/dialog_text.dart';
import 'package:stokpile/utilities/dialogs/generic_dialog.dart';

Future<void> showInfoDialog(
  BuildContext context, {
  required String text,
}) {
  return showGenericDialog<void>(
      context: context,
      title: infoTitle,
      content: Text(text),
      optionsBuilder: () => {
            dialogOk: null,
          });
}
