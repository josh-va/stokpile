import 'package:flutter/material.dart';
import 'package:stokpile/utilities/dialogs/components/dialog_backdrop.dart';

import 'package:stokpile/utilities/dialogs/components/gui_dialog_box.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

const Duration transitionDuration = Duration(milliseconds: 200);

Future<T?> showGenericGuiDialog<T>({
  required BuildContext context,
  required String title,
  required Widget content,
  required DialogOptionBuilder optionsBuilder,
  bool deleteWidget = false,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: false,
    barrierLabel: null,
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
      return PopScope(
        canPop: false,
        child: GuiDialogBox(
          title: title,
          content: content,
        ),
      );
    },
  );
}
