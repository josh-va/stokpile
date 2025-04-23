part of 'auth_bloc.dart';

Future<void> _convertAnonymousUserToEmail({
  required AuthEventConvertAnonymousToEmail event,
  required Emitter<AuthState> emit,
  required BaseAuthProvider provider,
}) async {
  emit(AuthStateConverting(
    user: provider.currentUser!,
    isLoading: true,
  ));
  try {
    await provider.convertAnonUser(
      email: event.email,
      password: event.password,
    );
    await provider.sendEmailVerification();
    emit(const AuthStateUnverifiedEmail());
  } on Exception catch (e) {
    emit(AuthStateLoggedInAnon(
      exception: e,
      user: provider.currentUser!,
    ));
  }
}

void _forgotPassword(Emitter<AuthState> emit) {
  emit(const AuthStateForgotPassword());
}

Future<void> _initialize({
  required Emitter<AuthState> emit,
  required BaseAuthProvider provider,
}) async {
  emit(const AuthStateUninitialized(isLoading: true));
  await provider.initialize();
  final user = provider.currentUser;
  if (user == null) {
    emit(const AuthStateUnauthenticated());
  } else if (user.isAnonymous) {
    emit(AuthStateLoggedInAnon(user: user));
  } else {
    emit(AuthStateLoggedIn(user: user));
  }
}

Future<void> _logIn({
  required Emitter<AuthState> emit,
  required AuthEventLogIn event,
  required BaseAuthProvider provider,
}) async {
  emit(const AuthStateUnauthenticated(isLoading: true));
  try {
    final user = await provider.logInEmail(
      email: event.email,
      password: event.password,
    );
    emit(AuthStateLoggedIn(user: user));
  } on AuthException catch (e) {
    emit(AuthStateUnauthenticated(exception: e));
  }
}

Future<void> _logInAnonymously({
  required Emitter<AuthState> emit,
  required BaseAuthProvider provider,
}) async {
  emit(AuthStateLoggedInAnon(isLoading: true));
  try {
    final user = await provider.logInAnonymously();
    emit(AuthStateLoggedInAnon(user: user));
  } on AuthException catch (e) {
    emit(AuthStateUnauthenticated(exception: e));
  }
}

Future<void> _logOut({
  required Emitter<AuthState> emit,
  required BaseAuthProvider provider,
}) async {
  try {
    emit(const AuthStateUnauthenticated(isLoading: true));
    await provider.logOut();
    emit(const AuthStateUnauthenticated());
  } on AuthException catch (e) {
    emit(AuthStateUnauthenticated(exception: e));
  }
}

Future<void> _sendEmailVerification({
  required Emitter<AuthState> emit,
  required BaseAuthProvider provider,
  required AuthState state,
}) async {
  await provider.sendEmailVerification();
  emit(state);
}

Future<void> _sendPasswordReminder({
  required AuthEventSendPasswordReminder event,
  required Emitter<AuthState> emit,
  required BaseAuthProvider provider,
}) async {
  emit(const AuthStateForgotPassword(
    isLoading: true,
  ));
  try {
    await provider.sendPasswordReset(event.email);
    emit(const AuthStateForgotPassword(hasSentEmail: true));
    emit(const AuthStateUnauthenticated());
  } on Exception catch (e) {
    emit(AuthStateForgotPassword(exception: e));
  }
}
