// TODO: fix up setup flow so that it doesn't kick the user from the Welcome path.
// Maybe having it save the profile info but not setting it to complete until the final step.

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/services/cloud/cloud_storage_provider.dart';
import 'package:stokpile/services/cloud/favorite.dart';
import 'package:stokpile/services/profile/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc_event_handlers.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(CloudStorageProvider provider)
      : super(const ProfileStateLoggedOut()) {
    _initializeEventHandlers(provider);
  }

  void _initializeEventHandlers(CloudStorageProvider provider) {
    on<ProfileEventLogIn>((event, emit) async => await _logIn(
          event: event,
          emit: emit,
          provider: provider,
          bloc: this,
        ));
    on<ProfileEventSetUpProfile>((event, emit) async => await _setUpProfile(
          event: event,
          emit: emit,
          provider: provider,
          bloc: this,
          state: state,
        ));
    on<ProfileEventCreateProfile>((event, emit) async => await _createProfile(
          event: event,
          provider: provider,
          bloc: this,
        ));
    on<ProfileEventFavoriteSet>((event, emit) async => await _favoriteSet(
          event: event,
          provider: provider,
          state: state,
          bloc: this,
        ));
    on<ProfileEventNameChange>((event, emit) async => await _nameChange(
          event: event,
          provider: provider,
          state: state,
          bloc: this,
        ));
    on<ProfileEventSettingChange>((event, emit) async => await _settingChange(
          event: event,
          provider: provider,
          state: state,
          bloc: this,
        ));
    on<ProfileEventLogOut>((event, emit) async => _logOut(emit));
  }
}
