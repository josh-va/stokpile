part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {
  final ThemeMode themeMode;
  const ThemeState(this.themeMode);
}

class ThemeStateSystem extends ThemeState {
  const ThemeStateSystem() : super(ThemeMode.system);
}

class ThemeStateLight extends ThemeState {
  const ThemeStateLight() : super(ThemeMode.light);
}

class ThemeStateDark extends ThemeState {
  const ThemeStateDark() : super(ThemeMode.dark);
}

class ThemeStateLoggedOut extends ThemeState {
  const ThemeStateLoggedOut() : super(ThemeMode.system);
}
