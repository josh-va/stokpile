import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/services/auth/auth_provider.dart';
import 'package:stokpile/services/auth/bloc/auth_bloc.dart';
import 'package:stokpile/services/cloud/cloud_storage_provider.dart';
import 'package:stokpile/services/entries/bloc/entries_bloc.dart';
import 'package:stokpile/services/profile/bloc/profile_bloc.dart';
import 'package:stokpile/theme/bloc/theme_cubit.dart';

BlocProvider<ThemeCubit> themeCubitProvider(
    CloudStorageProvider cloudStorageProvider) {
  return BlocProvider(
    create: (context) => ThemeCubit(cloudStorageProvider),
  );
}

BlocProvider<EntriesBloc> entriesBlocProvider(
    CloudStorageProvider cloudStorageProvider) {
  return BlocProvider(
    create: (context) => EntriesBloc(cloudStorageProvider),
  );
}

BlocProvider<ProfileBloc> profileBlocProvider(
    CloudStorageProvider cloudStorageProvider) {
  return BlocProvider(
    create: (context) => ProfileBloc(cloudStorageProvider),
  );
}

BlocProvider<AuthBloc> authBlocProvider(BaseAuthProvider authProvider) {
  return BlocProvider(
    create: (context) => AuthBloc(authProvider),
  );
}
