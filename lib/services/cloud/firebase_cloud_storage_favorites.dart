import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stokpile/constants/cloud_storage_constants.dart';
import 'package:stokpile/enums/entry_type_enum.dart';
import 'package:stokpile/exceptions/cloud_storage_exceptions.dart';
import 'package:stokpile/services/cloud/favorite.dart';
import 'package:stokpile/services/cloud/firebase_cloud_storage.dart';
import 'package:stokpile/services/entries/entry.dart';

class FirebaseCloudStorageFavorites {
  static final FirebaseCloudStorageFavorites _shared =
      FirebaseCloudStorageFavorites._sharedInstance();
  factory FirebaseCloudStorageFavorites() => _shared;
  FirebaseCloudStorageFavorites._sharedInstance();

  Future<void> createFavoriteEntry({
    required String uid,
    required EntryType type,
  }) async {
    final favorite = await getFavorite(
      uid: uid,
      type: type,
    );
    final inputEntry = Entry.fromFavorite(favorite!);
    FirebaseCloudStorage().createNewEntry(
      inputEntry: inputEntry,
      uid: uid,
    );
  }

  FirebaseFirestore get _db => FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> _favDoc(String uid) =>
      _userMetadata(uid).doc(favDocName);

  Future<Favorite?> getFavorite({
    required String uid,
    required EntryType type,
  }) async {
    late Map<String, dynamic> fav;
    final fetchedProfile = await _favDoc(uid).get();

    type == EntryType.save
        ? fav = fetchedProfile.get(favSaveFieldName)
        : fav = fetchedProfile.get(favSpendFieldName);

    if (fav[titleFieldName] == '' || fav[valueFieldName] == 0) {
      return null;
    }
    return Favorite(
      title: fav[titleFieldName],
      value: fav[valueFieldName],
      type: type,
      note: fav[noteFieldName],
    );
  }

  Future<void> setFavorite({
    required String uid,
    required Favorite favorite,
  }) async {
    final fav = favorite.asTypeWrappedMap;
    await _trySetFavorite(
      uid: uid,
      fav: fav,
    );
  }

  Future<void> _trySetFavorite({
    required String uid,
    required Map<String, Map<String, dynamic>> fav,
  }) async {
    try {
      await _favDoc(uid).set(
        fav,
        SetOptions(merge: true),
      );
    } catch (_) {
      throw CouldNotSetFavoriteException();
    }
  }

  CollectionReference<Map<String, dynamic>> _userMetadata(String uid) =>
      _userRoot(uid).collection(metadataCollectionName);

  DocumentReference<Map<String, dynamic>> _userRoot(String uid) =>
      _db.collection(userCollectionName).doc(uid);
}
