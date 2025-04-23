import 'package:flutter/material.dart';

class DialogLineText extends StatelessWidget {
  const DialogLineText({
    super.key,
    required this.iconColor,
    required this.controller,
    required this.hintText,
    required this.iconData,
  });

  final Color iconColor;
  final TextEditingController controller;
  final String hintText;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          iconData,
          color: iconColor,
        ),
      ),
      textAlignVertical: TextAlignVertical.center,
    );
  }
}
