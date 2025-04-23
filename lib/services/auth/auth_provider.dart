import 'package:stokpile/services/auth/auth_user.dart';

abstract class BaseAuthProvider {
  AuthUser? get currentUser;

  Future<AuthUser> convertAnonUser({
    required String email,
    required String password,
  });

  Future<AuthUser> createEmailUser({
    required String email,
    required String password,
  });

  Future<void> initialize();

  Future<AuthUser> logInAnonymously();

  Future<AuthUser> logInEmail({
    required String email,
    required String password,
  });

  Future<void> logOut();

  Future<void> sendEmailVerification();

  Future<void> sendPasswordReset(String toEmail);
}
