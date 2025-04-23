import 'package:flutter/material.dart';

class SlideInRoute extends PageRouteBuilder {
  final double x;
  final double y;
  final Widget widget;
  SlideInRoute({required this.widget, required this.x, required this.y})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return widget;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(x, y),
                end: Offset.zero,
              ).animate(animation),
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                  reverseCurve: Curves.easeIn,
                ),
                child: child,
              ),
            );
          },
        );
}
