import 'package:flutter/material.dart';
import 'package:stokpile/utilities/formatters/datetime_formatter.dart';

class DialogLineTime extends StatelessWidget {
  const DialogLineTime({
    super.key,
    required this.iconColor,
    required this.controller,
  });

  final Color iconColor;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.access_time_rounded,
          color: iconColor,
        ),
      ),
      textAlignVertical: TextAlignVertical.center,
      onTap: () async {
        final time = timeFromFormattedString(time: controller.text);
        final newTime = await showTimePicker(
          context: context,
          initialTime: time,
        );
        if (newTime != null) {
          controller.text = toFormattedTime(time: newTime);
        }
      },
    );
  }
}
