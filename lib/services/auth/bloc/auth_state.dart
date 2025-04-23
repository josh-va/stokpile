part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  final bool isLoading;
  final String? loadingText;
  final AuthUser? user;

  const AuthState({
    this.isLoading = false,
    this.loadingText = 'Please wait a moment...',
    this.user,
  });

  AuthUser get getActiveUser {
    assert(user != null, 'User should not be null in logged in subclass');
    return user!;
  }
}

class AuthStateConverting extends AuthState {
  final Exception? exception;

  const AuthStateConverting({
    this.exception,
    required AuthUser user,
    super.isLoading,
  }) : super(user: user);
}

class AuthStateForgotPassword extends AuthState {
  final Exception? exception;
  final bool hasSentEmail;

  const AuthStateForgotPassword({
    this.exception,
    this.hasSentEmail = false,
    super.isLoading,
  });
}

class AuthStateLoggedIn extends AuthState {
  const AuthStateLoggedIn({
    required AuthUser user,
    super.isLoading,
  }) : super(user: user);
}

class AuthStateLoggedInAnon extends AuthState {
  final Exception? exception;

  const AuthStateLoggedInAnon({
    super.user,
    this.exception,
    super.isLoading = false,
  });
}

class AuthStateUnauthenticated extends AuthState with EquatableMixin {
  final AuthException? exception;

  const AuthStateUnauthenticated({
    super.isLoading,
    this.exception,
    super.loadingText,
  });

  @override
  List<Object?> get props => [
        exception,
        isLoading,
        loadingText,
      ];
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({super.isLoading});
}

class AuthStateUnverifiedEmail extends AuthState {
  const AuthStateUnverifiedEmail({super.isLoading});
}
