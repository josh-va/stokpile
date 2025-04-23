import 'package:flutter/material.dart';
import 'package:stokpile/services/entries/entry.dart';
import 'package:stokpile/utilities/components/entry_cards/builds/add_entry_methods.dart';
import 'package:stokpile/utilities/components/entry_cards/builds/remove_entry_methods.dart';

const updateEntryRebuildDelay = Duration(milliseconds: 200);

List<Entry> createEntriesUpdatedList(
  List<Entry> entriesToAdd,
  List<Entry> entriesToRemove,
) {
  List<Entry> entriesUpdatedList = [];
  for (var entryAdd in entriesToAdd) {
    final addId = entryAdd.documentId;
    for (var entryRemove in entriesToRemove) {
      final removeId = entryRemove.documentId;
      if (addId == removeId) {
        entriesUpdatedList.add(entryAdd);
        entriesToAdd.remove(entryAdd);
        entriesToRemove.remove(entryRemove);
      }
      if (entriesToRemove.isEmpty) break;
    }
    if (entriesToAdd.isEmpty) break;
  }
  return entriesUpdatedList;
}

void updateChangedEntries({
  required List<Entry> entriesList,
  required Map<String, Map<String, bool>> expandedCardsList,
  required List<dynamic> displayedList,
  required List<Entry> entriesCacheList,
  required GlobalKey<AnimatedListState> animatedListKey,
}) {
  for (var entry in entriesList) {
    final oldIndex = entriesCacheList.indexWhere(
      (e) => e.documentId == entry.documentId,
    );
    final oldEntry = entriesCacheList[oldIndex];
    removeEntry(
      oldIndex: oldIndex,
      entry: entry,
      expandedCardsList: expandedCardsList,
      oldEntry: oldEntry,
      displayedList: displayedList,
      entriesCacheList: entriesCacheList,
      animatedListKey: animatedListKey,
      asUpdate: true,
    );
    addEntry(
      animatedListKey: animatedListKey,
      displayedList: displayedList,
      entriesCacheList: entriesCacheList,
      entry: entry,
      expandedCardsList: expandedCardsList,
      asUpdate: true,
    );
  }
  entriesList.clear();
}
