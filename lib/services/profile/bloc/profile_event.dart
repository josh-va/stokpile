part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {
  const ProfileEvent();
}

class ProfileEventLogIn extends ProfileEvent {
  final String uid;
  const ProfileEventLogIn(this.uid);
}

class ProfileEventLogOut extends ProfileEvent {
  const ProfileEventLogOut();
}

class ProfileEventCreateProfile extends ProfileEvent {
  final String uid;
  const ProfileEventCreateProfile(this.uid);
}

class ProfileEventNameChange extends ProfileEvent {
  final String name;
  const ProfileEventNameChange(this.name);
}

class ProfileEventSettingChange extends ProfileEvent {
  final String setting;
  final dynamic value;
  const ProfileEventSettingChange({
    required this.setting,
    required this.value,
  });
}

class ProfileEventFavoriteSet extends ProfileEvent {
  final Favorite favorite;
  const ProfileEventFavoriteSet(this.favorite);
}

class ProfileEventSetUpProfile extends ProfileEvent {
  final String name;
  final Favorite save;
  final Favorite spend;
  const ProfileEventSetUpProfile({
    required this.name,
    required this.save,
    required this.spend,
  });
}

class ProfileEventSetupComplete extends ProfileEvent {
  const ProfileEventSetupComplete();
}
