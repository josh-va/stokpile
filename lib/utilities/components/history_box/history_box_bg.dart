import 'package:flutter/material.dart';

class HistoryBoxBg extends StatelessWidget {
  const HistoryBoxBg({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        heightFactor: 0.61,
        widthFactor: 0.85,
        alignment: Alignment.center,
        child: Material(
            elevation: 5,
            color: Theme.of(context).colorScheme.surfaceContainer,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.elliptical(40, 20),
              ),
            ),
            child: child));
  }
}
