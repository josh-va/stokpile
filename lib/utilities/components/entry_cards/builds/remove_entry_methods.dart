import 'package:flutter/material.dart';
import 'package:stokpile/extensions/month_breakpoints.dart';
import 'package:stokpile/services/entries/entry.dart';
import 'package:stokpile/utilities/components/entry_cards/builds/entry_card_builds.dart';
import 'package:stokpile/utilities/components/entry_cards/builds/month_builds.dart';

void removeDeletedEntries({
  required List<Entry> entriesList,
  required Map<String, Map<String, bool>> expandedCardsList,
  required List<dynamic> displayedList,
  required List<Entry> entriesCacheList,
  required GlobalKey<AnimatedListState> animatedListKey,
}) {
  for (var entry in entriesList) {
    final entryIndex =
        entriesCacheList.indexWhere((e) => e.documentId == entry.documentId);
    removeEntry(
      oldIndex: entryIndex,
      entry: entry,
      expandedCardsList: expandedCardsList,
      oldEntry: entry,
      displayedList: displayedList,
      entriesCacheList: entriesCacheList,
      animatedListKey: animatedListKey,
    );
  }
}

void removeEntry({
  required int oldIndex,
  required Entry entry,
  required Entry oldEntry,
  required Map<String, Map<String, bool>> expandedCardsList,
  required List<dynamic> displayedList,
  required List<Entry> entriesCacheList,
  required GlobalKey<AnimatedListState> animatedListKey,
  bool asUpdate = false,
}) {
  displayedList = entriesCacheList.withMonthYearBreakpoints();
  entriesCacheList.removeAt(oldIndex);
  if (asUpdate == false) expandedCardsList.remove(entry.documentId);
  final listDiff = displayedList
      .where((e) => !entriesCacheList.withMonthYearBreakpoints().contains(e))
      .toList();
  final listIndex = displayedList.indexOf(oldEntry);
  displayedList = entriesCacheList.withMonthYearBreakpoints();
  demolishRemovedEntryCard(
    listIndex: listIndex,
    animatedListKey: animatedListKey,
    entry: entry,
  );
  if (listDiff.length == 2) {
    demolishEmptyMonth(listIndex, listDiff, animatedListKey);
  }
}
