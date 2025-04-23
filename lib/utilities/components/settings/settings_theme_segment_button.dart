import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/constants/cloud_storage_constants.dart';
import 'package:stokpile/constants/theme_modes.dart';
import 'package:stokpile/enums/theme_mode_enum.dart';
import 'package:stokpile/services/profile/bloc/profile_bloc.dart';

import 'package:stokpile/theme/bloc/theme_cubit.dart';

class ThemeSegmentedButton extends StatefulWidget {
  const ThemeSegmentedButton({super.key});

  @override
  State<ThemeSegmentedButton> createState() => _ThemeSegmentedButtonState();
}

class _ThemeSegmentedButtonState extends State<ThemeSegmentedButton> {
  late ThemeModes themeModeSelection;

  @override
  void initState() {
    if (context.read<ThemeCubit>().state is ThemeStateDark) {
      themeModeSelection = ThemeModes.dark;
    } else if (context.read<ThemeCubit>().state is ThemeStateLight) {
      themeModeSelection = ThemeModes.light;
    } else {
      themeModeSelection = ThemeModes.system;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ThemeModes>(
      segments: <ButtonSegment<ThemeModes>>[
        darkModeSegment(),
        systemModeSegment(),
        lightModeSegment(),
      ],
      selected: <ThemeModes>{themeModeSelection},
      onSelectionChanged: (Set<ThemeModes> newTheme) {
        setState(() {
          themeModeSelection = newTheme.first;

          if (themeModeSelection == ThemeModes.dark) {
            setThemeAndProfileDark(context);
          } else if (themeModeSelection == ThemeModes.system) {
            setThemeAndProfileSystem(context);
          } else {
            setThemeAndProfileLight(context);
          }
        });
      },
    );
  }

  ButtonSegment<ThemeModes> lightModeSegment() {
    return const ButtonSegment<ThemeModes>(
        value: ThemeModes.light,
        label: Text('Light'),
        icon: Icon(Icons.brightness_7_rounded));
  }

  ButtonSegment<ThemeModes> systemModeSegment() {
    return const ButtonSegment<ThemeModes>(
        value: ThemeModes.system,
        label: Text('System'),
        icon: Icon(Icons.brightness_4_rounded));
  }

  ButtonSegment<ThemeModes> darkModeSegment() {
    return const ButtonSegment<ThemeModes>(
        value: ThemeModes.dark,
        label: Text('Dark'),
        icon: Icon(Icons.brightness_2_rounded));
  }

  void setThemeAndProfileLight(BuildContext context) {
    context.read<ThemeCubit>().setLightTheme();
    context.read<ProfileBloc>().add(const ProfileEventSettingChange(
          setting: themeSettingFieldName,
          value: lightMode,
        ));
  }

  void setThemeAndProfileSystem(BuildContext context) {
    context.read<ThemeCubit>().setSystemTheme();
    context.read<ProfileBloc>().add(const ProfileEventSettingChange(
          setting: themeSettingFieldName,
          value: systemMode,
        ));
  }

  void setThemeAndProfileDark(BuildContext context) {
    context.read<ThemeCubit>().setDarkTheme();
    context.read<ProfileBloc>().add(const ProfileEventSettingChange(
          setting: themeSettingFieldName,
          value: darkMode,
        ));
  }
}
