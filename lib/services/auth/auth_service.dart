//Auth Service provides the factory constructors for the Auth Provider utilizing Firebase

import 'package:stokpile/services/auth/auth_provider.dart';
import 'package:stokpile/services/auth/auth_provider_firebase.dart';
import 'package:stokpile/services/auth/auth_user.dart';

class AuthService implements BaseAuthProvider {
  final BaseAuthProvider provider;
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> convertAnonUser({
    required String email,
    required String password,
  }) =>
      provider.convertAnonUser(
        email: email,
        password: password,
      );

  @override
  Future<AuthUser> createEmailUser({
    required String email,
    required String password,
  }) =>
      provider.createEmailUser(
        email: email,
        password: password,
      );

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<AuthUser> logInAnonymously() => provider.logInAnonymously();

  @override
  Future<AuthUser> logInEmail({
    required String email,
    required String password,
  }) =>
      provider.logInEmail(
        email: email,
        password: password,
      );

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> sendPasswordReset(toEmail) =>
      provider.sendPasswordReset(toEmail);
}
