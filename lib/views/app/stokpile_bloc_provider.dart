import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/services/auth/auth_provider.dart';
import 'package:stokpile/services/auth/auth_provider_firebase.dart';
import 'package:stokpile/services/cloud/firebase_cloud_storage.dart';
import 'package:stokpile/views/app/bloc_providers.dart';
import 'package:stokpile/views/app/stokpile_app.dart';

class StokpileBlocProvider extends StatelessWidget {
  const StokpileBlocProvider(
      {super.key, this.authProvider, this.cloudStorageProvider});
  final BaseAuthProvider? authProvider;
  final FirebaseCloudStorage? cloudStorageProvider;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        authBlocProvider(authProvider ?? FirebaseAuthProvider()),
        profileBlocProvider(cloudStorageProvider ?? FirebaseCloudStorage()),
        entriesBlocProvider(cloudStorageProvider ?? FirebaseCloudStorage()),
        themeCubitProvider(cloudStorageProvider ?? FirebaseCloudStorage()),
      ],
      child: const StokpileApp(),
    );
  }
}
