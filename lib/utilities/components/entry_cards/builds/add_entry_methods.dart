import 'package:flutter/material.dart';
import 'package:stokpile/extensions/month_breakpoints.dart';
import 'package:stokpile/constants/cloud_storage_constants.dart';
import 'package:stokpile/services/entries/entry.dart';

void addNewEntries({
  required List<Entry> entriesList,
  required Map<String, Map<String, bool>> expandedCardsList,
  required List<dynamic> displayedList,
  required List<Entry> entriesCacheList,
  required GlobalKey<AnimatedListState> animatedListKey,
}) {
  for (var entry in entriesList) {
    displayedList = entriesCacheList.withMonthYearBreakpoints();
    addEntry(
      animatedListKey: animatedListKey,
      displayedList: displayedList,
      entriesCacheList: entriesCacheList,
      entry: entry,
      expandedCardsList: expandedCardsList,
    );
  }
  entriesList.clear();
}

void addEntry({
  required Entry entry,
  required Map<String, Map<String, bool>> expandedCardsList,
  required List<dynamic> displayedList,
  required List<Entry> entriesCacheList,
  required GlobalKey<AnimatedListState> animatedListKey,
  bool asUpdate = false,
}) {
  displayedList = entriesCacheList.withMonthYearBreakpoints();
  entriesCacheList.add(entry);
  entriesCacheList.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  expandedCardsList.addAll({
    entry.documentId!: {
      entryCardIsExpandedFieldName: asUpdate
          ? expandedCardsList[entry.documentId]![entryCardIsExpandedFieldName]!
          : false,
      entryCardIsNewFieldName: true,
    }
  });
  final listDiff = entriesCacheList
      .withMonthYearBreakpoints()
      .where((element) => !displayedList.contains(element))
      .toList();
  displayedList = entriesCacheList.withMonthYearBreakpoints();
  final listIndex = displayedList.indexOf(entry);
  if (listDiff.length == 2) {
    animatedListKey.currentState!.insertAllItems(listIndex - 1, 2);
  } else {
    animatedListKey.currentState!.insertItem(listIndex);
  }
}
