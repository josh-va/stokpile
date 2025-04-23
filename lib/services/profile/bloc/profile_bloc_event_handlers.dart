part of 'profile_bloc.dart';

Future<void> _settingChange({
  required ProfileEventSettingChange event,
  required CloudStorageProvider provider,
  required ProfileState state,
  required ProfileBloc bloc,
}) async {
  final profile = state.getActiveProfile;
  await provider.updateSetting(
    uid: profile.uid,
    setting: event.setting,
    value: event.value,
  );
  bloc.add(ProfileEventLogIn(profile.uid));
}

Future<void> _nameChange({
  required ProfileEventNameChange event,
  required CloudStorageProvider provider,
  required ProfileState state,
  required ProfileBloc bloc,
}) async {
  final profile = state.getActiveProfile;
  await provider.updateProfileName(
    uid: profile.uid,
    name: event.name,
  );
  bloc.add(ProfileEventLogIn(profile.uid));
}

Future<void> _favoriteSet({
  required ProfileEventFavoriteSet event,
  required CloudStorageProvider provider,
  required ProfileState state,
  required ProfileBloc bloc,
}) async {
  final uid = state.getActiveProfile.uid;
  await provider.setFavorite(
    uid: uid,
    favorite: event.favorite,
  );
  bloc.add(ProfileEventLogIn(uid));
}

Future<void> _createProfile({
  required ProfileEventCreateProfile event,
  required CloudStorageProvider provider,
  required ProfileBloc bloc,
}) async {
  await provider.createNewProfile(event.uid);
  bloc.add(ProfileEventLogIn(event.uid));
}

_setUpProfile({
  required ProfileEventSetUpProfile event,
  required Emitter<ProfileState> emit,
  required CloudStorageProvider provider,
  required ProfileBloc bloc,
  required ProfileState state,
}) async {
  final uid = state.getActiveProfile.uid;
  bloc.add(ProfileEventNameChange(event.name));
  bloc.add(ProfileEventFavoriteSet(event.save));
  bloc.add(ProfileEventFavoriteSet(event.spend));
  final profile = await provider.getProfile(uid);
  await provider.updateSetupToComplete(uid);
  return emit(ProfileStateLoggedIn(
    profile: profile!,
    favSave: event.save,
    favSpend: event.spend,
  ));
}

_logIn({
  required ProfileEventLogIn event,
  required Emitter<ProfileState> emit,
  required CloudStorageProvider provider,
  required ProfileBloc bloc,
}) async {
  final profile = await provider.getProfile(event.uid);
  late final String setupStatus;
  if (profile == null) {
    setupStatus = 'no profile';
  } else if (profile.setupComplete == false) {
    setupStatus = 'incomplete setup';
  } else {
    setupStatus = 'complete';
  }
  switch (setupStatus) {
    case 'no profile':
      bloc.add(ProfileEventCreateProfile(event.uid));
      final profile = await provider.getProfile(event.uid);
      return emit(ProfileStateUserSetup(profile: profile));
    case 'incomplete setup':
      return emit(ProfileStateUserSetup(profile: profile));
    case 'complete':
      final favSave = await profile!.favoriteSave;
      final favSpend = await profile.favoriteSpend;
      return emit(ProfileStateLoggedIn(
        profile: profile,
        favSave: favSave!,
        favSpend: favSpend!,
      ));
    default:
      return emit(ProfileStateUserSetup(profile: profile));
  }
}

void _logOut(Emitter<ProfileState> emit) {
  emit(const ProfileStateLoggedOut());
}
