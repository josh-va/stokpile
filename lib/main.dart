import 'package:flutter/material.dart';
import 'package:stokpile/utilities/app_setup.dart';
import 'package:stokpile/views/app/stokpile_bloc_provider.dart';

void main() async {
  await appSetup();
  runApp(
    StokpileBlocProvider(),
  );
}
