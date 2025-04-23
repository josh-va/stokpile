import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/exceptions/auth_exceptions.dart';
import 'package:stokpile/services/auth/auth_provider.dart';
import 'package:stokpile/services/auth/auth_user.dart';

part 'auth_bloc_event_handers.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(BaseAuthProvider provider)
      : super(const AuthStateUninitialized(isLoading: true)) {
    _initializeEventHandlers(provider);
    add(const AuthEventInitialize());
  }

  void _initializeEventHandlers(BaseAuthProvider provider) {
    on<AuthEventConvertAnonymousToEmail>(
      (event, emit) async => await _convertAnonymousUserToEmail(
        event: event,
        emit: emit,
        provider: provider,
      ),
    );

    on<AuthEventForgotPassword>(
      (event, emit) async => _forgotPassword(emit),
    );

    on<AuthEventInitialize>(
      (event, emit) async => await _initialize(
        emit: emit,
        provider: provider,
      ),
    );

    on<AuthEventLogIn>(
      (event, emit) async => await _logIn(
        emit: emit,
        event: event,
        provider: provider,
      ),
    );

    on<AuthEventLogInAnonymously>(
      (event, emit) async => await _logInAnonymously(
        emit: emit,
        provider: provider,
      ),
    );

    on<AuthEventLogOut>(
      (event, emit) async => await _logOut(
        emit: emit,
        provider: provider,
      ),
    );

    on<AuthEventSendEmailVerification>(
      (event, emit) async => await _sendEmailVerification(
        emit: emit,
        provider: provider,
        state: state,
      ),
    );

    on<AuthEventSendPasswordReminder>(
      (event, emit) async => await _sendPasswordReminder(
        event: event,
        emit: emit,
        provider: provider,
      ),
    );
  }
}
