import 'package:flutter/material.dart';

abstract class Character {
  final String name;
  final Image image;
  final Alignment pivotPoint;

  Character({
    required this.name,
    required this.image,
    required this.pivotPoint,
  });

  get imageFacingLeft => image;
  get imageFacingRight => Transform.flip(
        flipX: true,
        flipY: false,
        child: image,
      );
}
