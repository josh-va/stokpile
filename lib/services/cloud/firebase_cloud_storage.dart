import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stokpile/enums/entry_type_enum.dart';
import 'package:stokpile/services/cloud/cloud_storage_provider.dart';
import 'package:stokpile/services/cloud/favorite.dart';
import 'package:stokpile/services/cloud/firebase_cloud_storage_entries.dart';
import 'package:stokpile/services/cloud/firebase_cloud_storage_favorites.dart';
import 'package:stokpile/services/cloud/firebase_cloud_storage_profiles.dart';
import 'package:stokpile/services/entries/entry.dart';
import 'package:stokpile/services/profile/profile.dart';

class FirebaseCloudStorage implements CloudStorageProvider {
  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;

  final FirebaseCloudStorageEntries firebaseCloudStorageEntries =
      FirebaseCloudStorageEntries();
  final FirebaseCloudStorageProfiles firebaseCloudStorageProfiles =
      FirebaseCloudStorageProfiles();
  final FirebaseCloudStorageFavorites firebaseCloudStorageFavorites =
      FirebaseCloudStorageFavorites();

  @override
  Future<Entry> createNewEntry({
    required Entry inputEntry,
    required String uid,
  }) =>
      firebaseCloudStorageEntries.createNewEntry(
        inputEntry: inputEntry,
        uid: uid,
      );

  @override
  Future<void> updateEntryWithEntry({
    required String uid,
    required Entry entry,
  }) =>
      firebaseCloudStorageEntries.updateEntryWithEntry(
        uid: uid,
        newEntry: entry,
      );

  @override
  Future<Entry> getEntry({
    required String documentId,
    required String uid,
  }) =>
      firebaseCloudStorageEntries.getEntry(
        documentId: documentId,
        uid: uid,
      );

  @override
  Stream<num> getCtotalStream(String uid) =>
      firebaseCloudStorageEntries.getCtotalStream(uid);

  @override
  Future<num> getCtotal(String uid) =>
      firebaseCloudStorageEntries.getCtotal(uid);

  @override
  Stream<Iterable<Entry>> getAllEntriesStream(String uid) =>
      firebaseCloudStorageEntries.getAllEntriesStream(uid);

  @override
  Future<List<Entry>> getAllEntriesSnapshot(String uid) =>
      firebaseCloudStorageEntries.getAllEntriesSnapshot(uid);

  @override
  Future<Entry> getLatestEntry(String uid) =>
      firebaseCloudStorageEntries.getLatestEntry(uid);

  @override
  Future<void> deleteEntry({
    required String uid,
    required String documentId,
  }) =>
      firebaseCloudStorageEntries.deleteEntry(
        uid: uid,
        documentId: documentId,
      );

  @override
  Future<void> deleteAllEntries(String uid) =>
      firebaseCloudStorageEntries.deleteAllEntries(uid);

  @override
  Future<num> updateCTotal({
    required String uid,
    required num value,
  }) =>
      firebaseCloudStorageProfiles.updateCTotal(
        uid: uid,
        value: value,
      );

  @override
  Future<Profile> createNewProfile(String uid) =>
      firebaseCloudStorageProfiles.createNewProfile(uid);

  @override
  Future<void> updateProfileName({
    required String uid,
    required String name,
  }) =>
      firebaseCloudStorageProfiles.updateProfileName(
        uid: uid,
        name: name,
      );

  @override
  Future<void> updateSetting({
    required String uid,
    required String setting,
    required dynamic value,
  }) =>
      firebaseCloudStorageProfiles.updateSetting(
        uid: uid,
        setting: setting,
        value: value,
      );

  @override
  Future<void> updateSetupToComplete(String uid) =>
      firebaseCloudStorageProfiles.updateSetupToComplete(uid);

  @override
  Future<Profile?> getProfile(String uid) =>
      firebaseCloudStorageProfiles.getProfile(uid);

  @override
  Future<void> checkValidSettings({
    required DocumentSnapshot<Map<String, dynamic>> userSettings,
    required String uid,
  }) =>
      firebaseCloudStorageProfiles.setDefaultSettingsIfMissing(
        userSettings: userSettings,
        uid: uid,
      );

  @override
  Future<void> setFavorite({
    required String uid,
    required Favorite favorite,
  }) =>
      firebaseCloudStorageFavorites.setFavorite(
        uid: uid,
        favorite: favorite,
      );

  @override
  Future<Favorite?> getFavorite({
    required String uid,
    required EntryType type,
  }) =>
      firebaseCloudStorageFavorites.getFavorite(
        uid: uid,
        type: type,
      );

  @override
  Future<void> createFavoriteEntry({
    required String uid,
    required EntryType type,
  }) =>
      firebaseCloudStorageFavorites.createFavoriteEntry(
        uid: uid,
        type: type,
      );

  @override
  Future<void> resetCTotal(String uid) =>
      firebaseCloudStorageProfiles.resetCTotal(uid);
}
