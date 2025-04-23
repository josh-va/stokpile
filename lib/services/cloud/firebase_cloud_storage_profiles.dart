import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stokpile/constants/cloud_storage_constants.dart';
import 'package:stokpile/constants/default_settings.dart';
import 'package:stokpile/exceptions/cloud_storage_exceptions.dart';
import 'package:stokpile/services/profile/profile.dart';

class FirebaseCloudStorageProfiles {
  static final FirebaseCloudStorageProfiles _shared =
      FirebaseCloudStorageProfiles._sharedInstance();
  factory FirebaseCloudStorageProfiles() => _shared;
  FirebaseCloudStorageProfiles._sharedInstance();

  Future<void> setDefaultSettingsIfMissing({
    required DocumentSnapshot<Map<String, dynamic>> userSettings,
    required String uid,
  }) async {
    final Set<String> diff =
        _diffBetweenCurrentAndExpectedSettings(userSettings);

    if (diff.isEmpty) {
      return;
    }
    for (var setting in diff) {
      await _profileDoc(uid).update({
        setting: Defaults.userSettings[setting],
      });
    }
  }

  FirebaseFirestore get _db => FirebaseFirestore.instance;

  Set<String> _diffBetweenCurrentAndExpectedSettings(
      DocumentSnapshot<Map<String, dynamic>> userSettings) {
    final currentSettingsKeys = userSettings.data()!.keys.toSet();
    final expectedSettingsKeys = Defaults.userSettings.keys.toSet();
    final diff = expectedSettingsKeys.difference(currentSettingsKeys);

    return diff;
  }

  Future<Profile> createNewProfile(String uid) async {
    try {
      await _applyDefaultUserSettings(uid);
      await _createEmptyFavorites(uid);
      await _setCtotalToZero(uid);

      final profile = await getProfile(uid);
      return profile!;
    } on Exception catch (_) {
      throw CouldNotCreateProfileException();
    }
  }

  Future<void> _setCtotalToZero(String uid) async {
    await _ctotalDoc(uid).set({ctotalFieldName: 0});
  }

  Future<void> _createEmptyFavorites(String uid) async {
    final emptyFavorite = {
      titleFieldName: '',
      valueFieldName: 0,
      noteFieldName: '',
    };

    await _favDoc(uid).set({
      favSaveFieldName: emptyFavorite,
      favSpendFieldName: emptyFavorite,
    });
  }

  Future<void> _applyDefaultUserSettings(String uid) async {
    await _profileDoc(uid).set(Defaults.userSettings);
  }

  DocumentReference<Map<String, dynamic>> _ctotalDoc(String uid) =>
      _userMetadata(uid).doc(ctotalDocName);

  DocumentReference<Map<String, dynamic>> _favDoc(String uid) =>
      _userMetadata(uid).doc(favDocName);

  Future<Profile?> getProfile(String uid) async {
    final userSettings = await _profileDoc(uid).get();
    if (userSettings.exists) {
      await setDefaultSettingsIfMissing(
        userSettings: userSettings,
        uid: uid,
      );
      return Profile.fromSnapshot(userSettings);
    } else {
      return null;
    }
  }

  DocumentReference<Map<String, dynamic>> _profileDoc(String uid) =>
      _userMetadata(uid).doc(profileDocName);

  Future<void> resetCTotal(String uid) async {
    await _ctotalDoc(uid).update({ctotalFieldName: 0});
  }

  Future<num> updateCTotal({
    required String uid,
    required num value,
  }) async {
    final currentCT = await _ctotalDoc(uid)
        .get()
        .then((value) => value.get(ctotalFieldName)) as num;
    final newValue = num.parse((currentCT + value).toStringAsFixed(2));

    await _ctotalDoc(uid).update({ctotalFieldName: newValue});
    return newValue;
  }

  Future<void> updateProfileName({
    required String uid,
    required String name,
  }) async {
    try {
      await _profileDoc(uid).update({nicknameFieldName: name});
    } on Exception catch (_) {
      throw CouldNotUpdateProfileNameException();
    }
  }

  Future<void> updateSetting({
    required String uid,
    required String setting,
    required dynamic value,
  }) async {
    try {
      await _profileDoc(uid).update({setting: value});
    } on Exception catch (_) {
      throw CouldNotUpdateProfileSettingsException();
    }
  }

  Future<void> updateSetupToComplete(String uid) async {
    try {
      await _profileDoc(uid).update({'setupComplete': true});
    } on Exception catch (_) {
      throw CouldNotUpdateProfileSettingsException();
    }
  }

  CollectionReference<Map<String, dynamic>> _userMetadata(String uid) =>
      _userRoot(uid).collection(metadataCollectionName);

  DocumentReference<Map<String, dynamic>> _userRoot(String uid) =>
      _db.collection(userCollectionName).doc(uid);
}
