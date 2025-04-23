import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stokpile/constants/cloud_storage_constants.dart';
import 'package:stokpile/enums/entry_type_enum.dart';
import 'package:stokpile/exceptions/cloud_storage_exceptions.dart';
import 'package:stokpile/services/cloud/firebase_cloud_storage.dart';
import 'package:stokpile/services/entries/entry.dart';

class FirebaseCloudStorageEntries {
  static final FirebaseCloudStorageEntries _shared =
      FirebaseCloudStorageEntries._sharedInstance();
  factory FirebaseCloudStorageEntries() => _shared;
  FirebaseCloudStorageEntries._sharedInstance();

  FirebaseFirestore get _db => FirebaseFirestore.instance;

  Future<Entry> createNewEntry({
    required Entry inputEntry,
    required String uid,
  }) async {
    try {
      final entry = await _addEntryToAccount(
        uid: uid,
        inputEntry: inputEntry,
      );

      return Entry.fromSnapshot(entry);
    } on Exception catch (_) {
      throw CouldNotCreateEntryException();
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _addEntryToAccount({
    required String uid,
    required Entry inputEntry,
  }) async {
    final entry = await _entriesCollection(uid)
        .add(inputEntry.asMap)
        .then((value) => value.get());
    final value = _invertValueIfSpendType(inputEntry);

    FirebaseCloudStorage().updateCTotal(
      uid: uid,
      value: value,
    );
    return entry;
  }

  DocumentReference<Map<String, dynamic>> _ctotalDoc(String uid) =>
      _userMetadata(uid).doc(ctotalDocName);

  Future<void> deleteAllEntries(String uid) async {
    final entries = await getAllEntriesSnapshot(uid);
    final batch = _db.batch();

    _populateBatchWithDelete(
      entries: entries,
      batch: batch,
      uid: uid,
    );
    await batch.commit();
  }

  void _populateBatchWithDelete({
    required List<Entry> entries,
    required WriteBatch batch,
    required String uid,
  }) {
    if (entries.isEmpty) {
      _addCtotalZeroToBatch(
        batch: batch,
        uid: uid,
      );
    } else {
      _addDeleteEntriesToBatch(
        entries: entries,
        batch: batch,
        uid: uid,
      );
      _addCtotalZeroToBatch(
        batch: batch,
        uid: uid,
      );
    }
  }

  void _addDeleteEntriesToBatch({
    required List<Entry> entries,
    required WriteBatch batch,
    required String uid,
  }) {
    const int limit = 200;
    for (var entry in entries.take(limit)) {
      batch.delete(_entriesCollection(uid).doc(entry.documentId));
    }
  }

  void _addCtotalZeroToBatch({
    required WriteBatch batch,
    required String uid,
  }) {
    batch.update(_ctotalDoc(uid), {
      ctotalFieldName: 0,
    });
  }

  Future<void> deleteEntry({
    required String uid,
    required String documentId,
  }) async {
    final entry = await getEntry(
      documentId: documentId,
      uid: uid,
    );
    final value = _invertValueIfSpendType(entry);

    try {
      await _entriesCollection(uid).doc(documentId).delete();
      await FirebaseCloudStorage().updateCTotal(
        uid: uid,
        value: -value,
      );
    } catch (_) {
      throw CouldNotDeleteEntryException();
    }
  }

  CollectionReference<Map<String, dynamic>> _entriesCollection(String uid) =>
      _userRoot(uid).collection(entriesCollectionName);

  Future<List<Entry>> getAllEntriesSnapshot(String uid) async {
    return await _entriesCollection(uid)
        .orderBy(timestampFieldName, descending: true)
        .limit(500)
        .get()
        .then((doc) => doc.docs.map((e) => Entry.fromSnapshot(e)).toList());
  }

  Stream<Iterable<Entry>> getAllEntriesStream(String uid) {
    return _entriesCollection(uid)
        .orderBy(
          timestampFieldName,
          descending: true,
        )
        .snapshots()
        .map((event) => event.docs.map((doc) => Entry.fromSnapshot(doc)));
  }

  Future<num> getCtotal(String uid) async {
    return await _ctotalDoc(uid)
        .get()
        .then((value) => value.get(ctotalFieldName)) as num;
  }

  Stream<num> getCtotalStream(String uid) {
    return _ctotalDoc(uid).snapshots().map(
      (event) {
        return event.get(ctotalFieldName);
      },
    );
  }

  Future<Entry> getEntry({
    required String documentId,
    required String uid,
  }) async {
    return await _entriesCollection(uid).doc(documentId).get().then(
          (doc) => Entry.fromSnapshot(doc),
        );
  }

  Future<Entry> getLatestEntry(String uid) async {
    final latestEntry = await _entriesCollection(uid)
        .orderBy(timestampFieldName)
        .limit(1)
        .get()
        .then((doc) => doc.docs.first);
    return Entry.fromSnapshot(latestEntry);
  }

  Future<void> updateEntryWithEntry({
    required String uid,
    required Entry newEntry,
  }) async {
    if (newEntry.type == EntryType.delete) {
      return deleteEntry(
        uid: uid,
        documentId: newEntry.documentId!,
      );
    }
    final oldEntry = await getEntry(
      documentId: newEntry.documentId!,
      uid: uid,
    );
    num cTotalDiff = newEntry.value - oldEntry.value;
    if (newEntry.type == EntryType.spend) {
      cTotalDiff = -cTotalDiff;
    }
    try {
      await _entriesCollection(uid)
          .doc(newEntry.documentId)
          .update(newEntry.asMap);
      if (newEntry.type == EntryType.spend) {
        cTotalDiff = -cTotalDiff;
      }
      FirebaseCloudStorage().updateCTotal(
        uid: uid,
        value: cTotalDiff,
      );
    } on Exception catch (_) {
      throw CouldNotUpdateEntryException();
    }
  }

  CollectionReference<Map<String, dynamic>> _userMetadata(String uid) =>
      _userRoot(uid).collection(metadataCollectionName);

  DocumentReference<Map<String, dynamic>> _userRoot(String uid) =>
      _db.collection(userCollectionName).doc(uid);

  num _invertValueIfSpendType(Entry entry) {
    if (entry.type == EntryType.spend) {
      return -entry.value;
    } else if (entry.type == EntryType.save) {
      return entry.value;
    } else {
      throw InvalidEntryTypeException();
    }
  }
}
