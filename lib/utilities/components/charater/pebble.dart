import 'package:flutter/material.dart';
import 'package:stokpile/utilities/components/charater/character.dart';

class Pebble extends Character {
  Pebble()
      : super(
          image: Image.asset('assets/pebbles/pebble.png'),
          name: 'Pebble',
          pivotPoint: Alignment(0, 0),
        );
}
