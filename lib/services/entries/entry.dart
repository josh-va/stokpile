import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:stokpile/constants/cloud_storage_constants.dart';
import 'package:stokpile/enums/entry_type_enum.dart';
import 'package:stokpile/services/cloud/favorite.dart';

@immutable
class Entry with EquatableMixin {
  final String? documentId;
  final String title;
  final num value;
  final Timestamp timestamp;
  final String? note;
  final EntryType type;

  const Entry({
    required this.documentId,
    required this.title,
    required this.value,
    required this.timestamp,
    required this.type,
    this.note,
  });

  Entry.fromFavorite(Favorite favorite)
      : documentId = null,
        title = favorite.title,
        value = favorite.value,
        timestamp = Timestamp.now(),
        type = favorite.type,
        note = favorite.note;

  Entry.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        title = snapshot.data()?[titleFieldName],
        value = snapshot.data()?[valueFieldName] as num,
        timestamp = snapshot.data()?[timestampFieldName] as Timestamp,
        type = EntryTypeParse.fromString(snapshot.data()?[typeFieldName]),
        note = snapshot.data()?[noteFieldName];

  String get monthYearString => DateFormat.yMMMM().format(timestamp.toDate());

  Map<String, dynamic> get asMap {
    return {
      titleFieldName: title,
      valueFieldName: value,
      typeFieldName: type.name,
      timestampFieldName: timestamp,
      noteFieldName: note,
    };
  }

  @override
  List<Object?> get props => [
        documentId,
        title,
        value,
        timestamp,
        note,
      ];
}
