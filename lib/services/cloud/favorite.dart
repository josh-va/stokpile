import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:stokpile/constants/cloud_storage_constants.dart';
import 'package:stokpile/enums/entry_type_enum.dart';

@immutable
class Favorite {
  final String title;
  final num value;
  final String? note;
  final EntryType type;

  const Favorite({
    required this.title,
    required this.value,
    required this.type,
    this.note,
  });

  Favorite.fromSnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
    String favtype,
  )   : title = snapshot.data()[titleFieldName] as String,
        value = snapshot.data()[valueFieldName] as num,
        type = EntryTypeParse.fromString(favtype),
        note = snapshot.data()[noteFieldName] as String;

  Map<String, dynamic> get asMap {
    return {
      titleFieldName: title,
      valueFieldName: value,
      typeFieldName: type,
      noteFieldName: note ?? '',
    };
  }

  Map<String, Map<String, dynamic>> get asTypeWrappedMap {
    final typeWrapper = 'fav${type.name}';
    return {
      typeWrapper: {
        titleFieldName: title,
        valueFieldName: value,
        noteFieldName: note ?? '',
      }
    };
  }
}
