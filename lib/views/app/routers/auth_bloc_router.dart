import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/constants/messages.dart';
import 'package:stokpile/services/auth/bloc/auth_bloc.dart';
import 'package:stokpile/utilities/loading_screen/empty_loading_state.dart';
import 'package:stokpile/utilities/loading_screen/loading_screen.dart';
import 'package:stokpile/views/app/routers/profile_bloc_router.dart';
import 'package:stokpile/views/auth/gui_auth/gui_main_menu_view.dart';

class AuthBlocRouter extends StatelessWidget {
  const AuthBlocRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, authState) {
        showLoadingScreenWhenAuthLoading(authState, context);
      },
      builder: (context, authState) {
        switch (authState) {
          case AuthStateUnauthenticated():
            return const GuiMainMenuView();

          case AuthStateLoggedIn() || AuthStateLoggedInAnon():
            return ProfileBlocRouter(authState);

          default:
            return const LoadingState();
        }
      },
    );
  }

  void showLoadingScreenWhenAuthLoading(
      AuthState authState, BuildContext context) {
    if (authState.isLoading) {
      LoadingScreen().show(
        context: context,
        text: authState.loadingText ?? loadingScreenText,
      );
    } else {
      LoadingScreen().hide();
    }
  }
}
