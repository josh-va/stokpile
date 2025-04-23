import 'package:flutter/material.dart';

class EmptyFlexSpace extends StatelessWidget {
  const EmptyFlexSpace(
    this.flex, {
    super.key,
  });
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: Container(),
    );
  }
}
