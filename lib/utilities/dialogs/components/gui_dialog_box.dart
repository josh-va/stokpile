import 'package:flutter/material.dart';

class GuiDialogBox extends StatelessWidget {
  const GuiDialogBox({
    super.key,
    required this.title,
    required this.content,
  });
  final String title;
  final Widget content;

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
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
