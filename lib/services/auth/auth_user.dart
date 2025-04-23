import "package:firebase_auth/firebase_auth.dart" show User;
import "package:flutter/foundation.dart";

@immutable
class AuthUser {
  final bool isEmailVerified;
  final bool isAnonymous;
  final String? email;
  final String uid;

  const AuthUser({
    this.isEmailVerified = false,
    this.isAnonymous = false,
    this.email,
    required this.uid,
  });

  factory AuthUser.fromFirebase(User user) => AuthUser(
        isEmailVerified: user.emailVerified,
        isAnonymous: user.isAnonymous,
        email: user.email,
        uid: user.uid,
      );
}
