import 'package:flutter/material.dart';
import 'package:stokpile/constants/cloud_storage_constants.dart';
import 'package:stokpile/extensions/month_breakpoints.dart';
import 'package:stokpile/services/entries/entry.dart';
import 'package:stokpile/utilities/components/entry_cards/builds/entry_card_builds.dart';
import 'package:stokpile/utilities/components/entry_cards/builds/month_builds.dart';

class HistoryBoxContents extends StatelessWidget {
  const HistoryBoxContents({
    super.key,
    required this.animatedListKey,
    required this.entriesCache,
    required this.entryCardMetadata,
  });

  final GlobalKey<AnimatedListState> animatedListKey;
  final List<Entry> entriesCache;
  final Map<String, Map<String, bool>> entryCardMetadata;

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: animatedListKey,
      padding: EdgeInsets.zero,
      initialItemCount: entriesCache.withMonthYearBreakpoints().length,
      itemBuilder: (
        context,
        index,
        animation,
      ) {
        final entry = entriesCache.withMonthYearBreakpoints()[index];
        if (entry is String) {
          return BuildMonth(
            month: entry,
            animation: animation,
          );
        } else {
          final card = BuildEntryCard(
            expandedList: entryCardMetadata,
            entry: entry,
            animation: animation,
            expanded: entryCardMetadata[entry.documentId]![
                entryCardIsExpandedFieldName]!,
            animateWidget:
                entryCardMetadata[entry.documentId]![entryCardIsNewFieldName]!,
            tapCallback: () {
              entryCardTapCallback(
                  entryCardMetadata: entryCardMetadata, entry: entry);
            },
          );
          if (entryCardMetadata[entry.documentId]![entryCardIsNewFieldName] ==
              true) {
            entryCardMetadata[entry.documentId]![entryCardIsNewFieldName] =
                false;
          }
          return card;
        }
      },
    );
  }
}
