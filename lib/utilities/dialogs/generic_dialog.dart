import 'package:flutter/material.dart';
import 'package:stokpile/utilities/dialogs/components/dialog_backdrop.dart';
import 'package:stokpile/utilities/dialogs/components/dialog_box.dart';
import 'package:stokpile/utilities/dialogs/dialog_text.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

const Duration transitionDuration = Duration(milliseconds: 200);

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required Widget content,
  required DialogOptionBuilder optionsBuilder,
  bool deleteWidget = false,
}) {
  final options = optionsBuilder();
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: true,
    barrierLabel: dialogCancel,
    transitionDuration: transitionDuration,
    transitionBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) {
      return DialogBackdrop(
        animation: animation,
        child: child,
      );
    },
    barrierColor: Colors.black26,
    pageBuilder: (
      context,
      animation,
      secondaryAnimation,
    ) {
      return DialogBox(
        title: title,
        content: content,
        options: options,
        deleteWidget: deleteWidget,
      );
    },
  );
}
