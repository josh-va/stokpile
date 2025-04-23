import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/constants/theme_modes.dart';
import 'package:stokpile/services/cloud/cloud_storage_provider.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final CloudStorageProvider _provider;
  ThemeCubit(this._provider) : super(ThemeStateLoggedOut());

  void setDarkTheme() => emit(ThemeStateDark());
  void setLightTheme() => emit(ThemeStateLight());
  void setSystemTheme() => emit(ThemeStateSystem());

  Future<void> getProfileState(String uid) async {
    final profile = await _provider.getProfile(uid);
    if (profile == null) {
      emit(const ThemeStateLoggedOut());
      return;
    }
    switch (profile.theme) {
      case darkMode:
        emit(ThemeStateDark());
      case systemMode:
        emit(ThemeStateSystem());
      case lightMode:
        emit(ThemeStateLight());
    }
  }

  void logOut() => emit(const ThemeStateLoggedOut());
}
