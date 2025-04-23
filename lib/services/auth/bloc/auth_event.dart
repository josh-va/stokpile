part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

class AuthEventConvertAnonymousToEmail extends AuthEvent {
  final String email;
  final String password;

  const AuthEventConvertAnonymousToEmail({
    required this.email,
    required this.password,
  });
}

class AuthEventForgotPassword extends AuthEvent {
  const AuthEventForgotPassword();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventLogIn extends AuthEvent {
  final String email;
  final String password;

  const AuthEventLogIn({
    required this.email,
    required this.password,
  });
}

class AuthEventLogInAnonymously extends AuthEvent {
  const AuthEventLogInAnonymously();
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}

class AuthEventSendEmailVerification extends AuthEvent {
  const AuthEventSendEmailVerification();
}

class AuthEventSendPasswordReminder extends AuthEvent {
  final String email;

  const AuthEventSendPasswordReminder(this.email);
}
