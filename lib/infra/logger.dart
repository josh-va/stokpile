import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:stokpile/constants/ansi_escape_codes.dart';

late String textColor;
late String backgroundColor;

void initializeDebugLogger() {
  if (kDebugMode) {
    Logger.root.level = Level.ALL;
  } else {
    Logger.root.level = Level.OFF;
  }
  hierarchicalLoggingEnabled = true;

  Logger.root.onRecord.listen((record) {
    if (!kDebugMode) {
      return;
    }

    switch (record.level.name) {
      case 'INFO':
        textColor = whiteText;
        backgroundColor = defaultBackground;

      case 'WARNING':
        textColor = yellowText;
        backgroundColor = defaultBackground;

      case 'SEVERE':
        textColor = redText;
        backgroundColor = yellowBackground;

      case 'SHOUT':
        textColor = yellowText;
        backgroundColor = redBackground;

      default:
        textColor = greyText;
        backgroundColor = defaultBackground;
    }

    final message =
        '$defaultBackground$whiteText${record.time}:$backgroundColor$textColor${record.level.name}: ${record.message}$defaultAll';

    developer.log(
      message,
      name: record.loggerName.padRight(25),
      level: record.level.value,
      time: record.time,
    );
  });
}
