import 'package:flutter/material.dart';
import 'package:stokpile/utilities/formatters/datetime_formatter.dart';

class DialogLineCalendar extends StatelessWidget {
  const DialogLineCalendar({
    super.key,
    required this.iconColor,
    required this.controller,
  });

  final TextEditingController controller;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.calendar_month_rounded,
          color: iconColor,
        ),
      ),
      textAlignVertical: TextAlignVertical.center,
      onTap: () async {
        final date = dateFromFormattedString(date: controller.text);
        final newDate = await showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          initialDate: date,
        );
        if (newDate != null) {
          controller.text = toFormattedDate(date: newDate);
        }
      },
    );
  }
}
