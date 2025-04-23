import 'package:flutter/material.dart';

const double topAlign = -1.0;
const EdgeInsetsGeometry padding = EdgeInsets.all(8.0);

class EntryCardTransition extends StatelessWidget {
  const EntryCardTransition(
      {super.key,
      required this.child,
      required this.animation,
      required this.transitionAlignment});
  final Widget child;
  final Animation<double> animation;
  final double transitionAlignment;
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animation,
        curve: Curves.easeIn,
      ),
      axisAlignment: transitionAlignment,
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.easeIn,
        ),
        child: child,
      ),
    );
  }
}
