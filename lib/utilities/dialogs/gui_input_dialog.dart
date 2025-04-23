import 'package:flutter/material.dart';
import 'package:stokpile/utilities/dialogs/dialog_text.dart';
import 'package:stokpile/utilities/dialogs/gui_intro_dialogs/gui_dialog_base.dart';

TextEditingController _textFieldController = TextEditingController();

Future<String?> showGuiInputDialog(
  BuildContext context, {
  required String text,
  required String hintText,
  String? errorText,
}) async {
  final proceed = await showGenericGuiDialog<bool>(
    context: context,
    title: text,
    content: contents(
      errorText: errorText,
      hintText: hintText,
    ),
    optionsBuilder: () => {
      dialogCancel: false,
      dialogContinue: true,
    },
  );
  final input = _textFieldController.text;
  _textFieldController.text = '';
  if (proceed == true && input != '') {
    return input;
  } else if (proceed == true && input == '' && context.mounted) {
    return hintText;
  } else {
    return null;
  }
}

Widget contents({errorText, required hintText}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      TextField(
        controller: _textFieldController,
        decoration: InputDecoration(hintText: hintText),
      ),
      if (errorText != null)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            errorText,
            style: const TextStyle(color: Colors.red),
          ),
        ),
    ],
  );
}
