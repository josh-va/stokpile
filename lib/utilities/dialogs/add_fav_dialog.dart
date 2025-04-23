import 'package:flutter/material.dart';
import 'package:stokpile/enums/entry_type_enum.dart';
import 'package:stokpile/services/entries/entry.dart';
import 'package:stokpile/utilities/dialogs/dialog_text.dart';
import 'package:stokpile/utilities/dialogs/generic_dialog.dart';

Future<bool> showAddFavDialog(BuildContext context, {required Entry entry}) {
  late String title;
  late String body;
  if (entry.type == EntryType.save) {
    title = saveTitle;
    body = saveBody(entry);
  } else {
    title = spendTitle;
    body = spendBody(entry);
  }
  return showGenericDialog<bool>(
    context: context,
    title: title,
    content: Text(body),
    optionsBuilder: () => {
      dialogNo: false,
      dialogYes: true,
    },
  ).then((value) => value ?? false);
}
