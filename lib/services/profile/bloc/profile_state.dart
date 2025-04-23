part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {
  final Profile? profile;
  const ProfileState({this.profile});

  Profile get getActiveProfile {
    assert(profile != null, 'Profile should not be null when this is called!');
    return profile!;
  }
}

class ProfileStateLoggedOut extends ProfileState {
  const ProfileStateLoggedOut({super.profile});
}

class ProfileStateUserSetup extends ProfileState with EquatableMixin {
  final String? name;
  final Favorite? favSave;
  final Favorite? favSpend;
  const ProfileStateUserSetup({
    super.profile,
    this.name,
    this.favSave,
    this.favSpend,
  });

  @override
  List<Object?> get props => [
        profile,
        name,
        favSave,
        favSpend,
      ];
}

class ProfileStateLoggedIn extends ProfileState with EquatableMixin {
  final Favorite favSave;
  final Favorite favSpend;
  const ProfileStateLoggedIn({
    required Profile super.profile,
    required this.favSave,
    required this.favSpend,
  });

  @override
  List<Object?> get props => [
        profile,
        favSave,
        favSpend,
      ];
}
