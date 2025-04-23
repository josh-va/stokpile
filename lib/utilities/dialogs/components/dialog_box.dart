import 'package:flutter/material.dart';
import 'package:stokpile/constants/cloud_storage_constants.dart';

class DialogBox extends StatelessWidget {
  const DialogBox(
      {super.key,
      required this.options,
      required this.title,
      required this.content,
      required this.deleteWidget});

  final Map<String, dynamic> options;
  final String title;
  final Widget content;
  final bool deleteWidget;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          title,
          style:
              TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ),
      content: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
            minWidth: 400,
          ),
          child: content),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.elliptical(
          20,
          10,
        )),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl,
          children: [
            Row(
              children: optionsButtons(context),
            ),
            if (deleteWidget) deleteButton(context),
          ],
        ),
      ],
    );
  }

  TextButton deleteButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop(deleteEntryType);
      },
      child: Text('Delete',
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
          )),
    );
  }

  List<TextButton> optionsButtons(BuildContext context) {
    return options.keys.map(
      (optionTitle) {
        final value = options[optionTitle];
        return TextButton(
          onPressed: () {
            Navigator.of(context).pop(value);
          },
          child: Text(
            optionTitle,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        );
      },
    ).toList();
  }
}
