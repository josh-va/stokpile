import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/constants/general.dart';
import 'package:stokpile/theme/bloc/theme_cubit.dart';
import 'package:stokpile/theme/material_theme.dart';
import 'package:stokpile/views/app/routers/auth_bloc_router.dart';

class StokpileApp extends StatelessWidget {
  const StokpileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return SafeArea(
          child: MaterialApp(
            title: appName,
            theme: getMaterialTheme(context).light(),
            darkTheme: getMaterialTheme(context).dark(),
            themeMode: state.themeMode,
            home: const AuthBlocRouter(),
          ),
        );
      },
    );
  }
}
