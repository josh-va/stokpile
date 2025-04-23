import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/services/auth/auth_user.dart';
import 'package:stokpile/services/auth/bloc/auth_bloc.dart';
import 'package:stokpile/services/entries/bloc/entries_bloc.dart';
import 'package:stokpile/services/profile/bloc/profile_bloc.dart';
import 'package:stokpile/theme/bloc/theme_cubit.dart';
import 'package:stokpile/utilities/loading_screen/empty_loading_state.dart';
import 'package:stokpile/views/auth/gui_auth/gui_welcome_view.dart';
import 'package:stokpile/views/auth/primary_flow/primary_view.dart';

class ProfileBlocRouter extends StatelessWidget {
  const ProfileBlocRouter(
    this.authState, {
    super.key,
  });

  final AuthState authState;

  @override
  Widget build(BuildContext context) {
    while (authState.user == null) {
      return const LoadingState();
    }
    final authUser = authState.getActiveUser;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        switch (profileState) {
          case ProfileStateLoggedOut():
            logInProfileBloc(context, authUser);
            return const LoadingState();

          case ProfileStateUserSetup():
            return const GuiWelcomeView();

          case ProfileStateLoggedIn():
            getProfileTheme(context, authUser);
            logInEntriesBloc(context, authUser);
            return const PrimaryView();

          default:
            return const LoadingState();
        }
      },
    );
  }
}

void logInEntriesBloc(BuildContext context, AuthUser authUser) {
  context.read<EntriesBloc>().add(EntriesEventLogIn(authUser.uid));
}

Future<void> getProfileTheme(BuildContext context, AuthUser authUser) async {
  context.read<ThemeCubit>().getProfileState(authUser.uid);
}

void logInProfileBloc(BuildContext context, AuthUser authUser) {
  context.read<ProfileBloc>().add(ProfileEventLogIn(authUser.uid));
}
