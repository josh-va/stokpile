// N.B. To use colors from the active scheme call Theme.of(context).colorScheme.{color}
// Or even better store the value of the colorScheme locally in the widget to make it more readable
// i.e. final colorScheme = Theme.of(context).colorScheme;
// and then call colorScheme.{color} within the widget.
// Either way, the Theme.of(context) call is cheap and not going to make or break performance

import "package:flutter/material.dart";
import "package:stokpile/theme/text_theme.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme({required this.textTheme});

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff865319),
      surfaceTint: Color(0xff865319),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffdcbf),
      onPrimaryContainer: Color(0xff2d1600),
      secondary: Color(0xff735942),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffdcbf),
      onSecondaryContainer: Color(0xff291806),
      tertiary: Color(0xff596339),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffdde8b3),
      onTertiaryContainer: Color(0xff171e00),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff211a14),
      onSurfaceVariant: Color(0xff51443a),
      outline: Color(0xff837469),
      outlineVariant: Color(0xffd5c3b6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff372f28),
      inversePrimary: Color(0xfffdb876),
      primaryFixed: Color(0xffffdcbf),
      onPrimaryFixed: Color(0xff2d1600),
      primaryFixedDim: Color(0xfffdb876),
      onPrimaryFixedVariant: Color(0xff6a3c01),
      secondaryFixed: Color(0xffffdcbf),
      onSecondaryFixed: Color(0xff291806),
      secondaryFixedDim: Color(0xffe2c0a4),
      onSecondaryFixedVariant: Color(0xff59422d),
      tertiaryFixed: Color(0xffdde8b3),
      onTertiaryFixed: Color(0xff171e00),
      tertiaryFixedDim: Color(0xffc1cc99),
      onTertiaryFixedVariant: Color(0xff414b24),
      surfaceDim: Color(0xffe6d7cd),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e8),
      surfaceContainer: Color(0xfffaebe0),
      surfaceContainerHigh: Color(0xfff5e5db),
      surfaceContainerHighest: Color(0xffefe0d5),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffdb876),
      surfaceTint: Color(0xfffdb876),
      onPrimary: Color(0xff4a2800),
      primaryContainer: Color(0xff6a3c01),
      onPrimaryContainer: Color(0xffffdcbf),
      secondary: Color(0xffe2c0a4),
      onSecondary: Color(0xff412c18),
      secondaryContainer: Color(0xff59422d),
      onSecondaryContainer: Color(0xffffdcbf),
      tertiary: Color(0xffc1cc99),
      onTertiary: Color(0xff2b340f),
      tertiaryContainer: Color(0xff414b24),
      onTertiaryContainer: Color(0xffdde8b3),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff19120c),
      onSurface: Color(0xffefe0d5),
      onSurfaceVariant: Color(0xffd5c3b6),
      outline: Color(0xff9e8e81),
      outlineVariant: Color(0xff51443a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffefe0d5),
      inversePrimary: Color(0xff865319),
      primaryFixed: Color(0xffffdcbf),
      onPrimaryFixed: Color(0xff2d1600),
      primaryFixedDim: Color(0xfffdb876),
      onPrimaryFixedVariant: Color(0xff6a3c01),
      secondaryFixed: Color(0xffffdcbf),
      onSecondaryFixed: Color(0xff291806),
      secondaryFixedDim: Color(0xffe2c0a4),
      onSecondaryFixedVariant: Color(0xff59422d),
      tertiaryFixed: Color(0xffdde8b3),
      onTertiaryFixed: Color(0xff171e00),
      tertiaryFixedDim: Color(0xffc1cc99),
      onTertiaryFixedVariant: Color(0xff414b24),
      surfaceDim: Color(0xff19120c),
      surfaceBright: Color(0xff403830),
      surfaceContainerLowest: Color(0xff130d07),
      surfaceContainerLow: Color(0xff211a14),
      surfaceContainer: Color(0xff261e18),
      surfaceContainerHigh: Color(0xff312822),
      surfaceContainerHighest: Color(0xff3c332c),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );
}

MaterialTheme getMaterialTheme(BuildContext context) {
  TextTheme textTheme = createTextTheme(
    context: context,
  );
  MaterialTheme materialTheme = MaterialTheme(textTheme: textTheme);
  return materialTheme;
}
