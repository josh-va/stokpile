import 'package:flutter/material.dart';
import 'package:stokpile/utilities/components/charater/character.dart';

class King extends Character {
  King()
      : super(
          image: Image.asset('assets/pebbles/king.png'),
          name: 'Lord Rockyfeller',
          pivotPoint: Alignment(0, 0.5),
        );
}
