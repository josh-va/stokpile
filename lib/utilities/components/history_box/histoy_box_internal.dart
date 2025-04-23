import 'package:flutter/material.dart';

class HistoryBoxInternal extends StatelessWidget {
  const HistoryBoxInternal(
      {super.key, required this.header, required this.contents});

  final Widget contents;
  final Widget header;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
      child: Column(
        children: [
          header,
          Flexible(child: contents),
        ],
      ),
    );
  }
}
