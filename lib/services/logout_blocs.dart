import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/services/auth/bloc/auth_bloc.dart';
import 'package:stokpile/services/entries/bloc/entries_bloc.dart';
import 'package:stokpile/services/profile/bloc/profile_bloc.dart';
import 'package:stokpile/theme/bloc/theme_cubit.dart';

Future<void> logoutAllBlocs(BuildContext context) async {
  context.read<ProfileBloc>().add(const ProfileEventLogOut());
  context.read<EntriesBloc>().add(const EntriesEventLogOut());
  context.read<ThemeCubit>().logOut();
  context.read<AuthBloc>().add(const AuthEventLogOut());
}
