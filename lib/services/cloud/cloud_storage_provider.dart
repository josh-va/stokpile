import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stokpile/enums/entry_type_enum.dart';
import 'package:stokpile/services/cloud/favorite.dart';
import 'package:stokpile/services/entries/entry.dart';
import 'package:stokpile/services/profile/profile.dart';

abstract class CloudStorageProvider {
  Future<Entry> createNewEntry({
    required Entry inputEntry,
    required String uid,
  });

  Future<void> updateEntryWithEntry({
    required String uid,
    required Entry entry,
  });

  Future<Entry> getEntry({
    required String documentId,
    required String uid,
  });

  Stream<num> getCtotalStream(String uid);

  Future<num> getCtotal(String uid);

  Stream<Iterable<Entry>> getAllEntriesStream(String uid);

  Future<List<Entry>> getAllEntriesSnapshot(String uid);

  Future<Entry> getLatestEntry(String uid);

  Future<void> deleteEntry({
    required String uid,
    required String documentId,
  });

  Future<void> deleteAllEntries(String uid);

  Future<num> updateCTotal({
    required String uid,
    required num value,
  });

  Future<Profile> createNewProfile(String uid);

  Future<void> updateProfileName({
    required String uid,
    required String name,
  });

  Future<void> updateSetting({
    required String uid,
    required String setting,
    required dynamic value,
  });

  Future<void> updateSetupToComplete(String uid);

  Future<Profile?> getProfile(String uid);

  Future<void> checkValidSettings({
    required DocumentSnapshot<Map<String, dynamic>> userSettings,
    required String uid,
  });

  Future<void> setFavorite({
    required String uid,
    required Favorite favorite,
  });

  Future<Favorite?> getFavorite({
    required String uid,
    required EntryType type,
  });

  Future<void> createFavoriteEntry({
    required String uid,
    required EntryType type,
  });

  Future<void> resetCTotal(String uid);
}
