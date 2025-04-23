import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:stokpile/constants/cloud_storage_constants.dart';
import 'package:stokpile/enums/entry_type_enum.dart';
import 'package:stokpile/services/cloud/favorite.dart';
import 'package:stokpile/services/cloud/firebase_cloud_storage.dart';

@immutable
class Profile with EquatableMixin {
  final String uid;
  final String name;
  final int theme;
  final bool overdrawing;
  final bool notes;
  final bool setupComplete;

  const Profile({
    required this.uid,
    required this.name,
    required this.theme,
    required this.overdrawing,
    required this.notes,
    required this.setupComplete,
  });

  Future<Favorite?> get favoriteSpend async =>
      await FirebaseCloudStorage().getFavorite(
        type: EntryType.spend,
        uid: uid,
      );

  Future<Favorite?> get favoriteSave async =>
      await FirebaseCloudStorage().getFavorite(
        type: EntryType.save,
        uid: uid,
      );

  Profile.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> userSettingsSnapshot)
      : uid = userSettingsSnapshot.reference.parent.parent!.id,
        name = userSettingsSnapshot.data()?[nicknameFieldName] as String,
        theme = userSettingsSnapshot.data()?[themeSettingFieldName] as int,
        overdrawing =
            userSettingsSnapshot.data()?[overdrawingSettingFieldName] as bool,
        notes = userSettingsSnapshot.data()?[notesSettingFieldName] as bool,
        setupComplete =
            userSettingsSnapshot.data()?[setupCompleteFieldName] as bool;

  @override
  List<Object?> get props => [
        uid,
        name,
        theme,
        overdrawing,
        notes,
        setupComplete,
      ];
}
