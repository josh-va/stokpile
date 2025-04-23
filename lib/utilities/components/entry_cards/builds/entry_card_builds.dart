import 'package:flutter/material.dart';
import 'package:stokpile/constants/cloud_storage_constants.dart';
import 'package:stokpile/services/entries/entry.dart';
import 'package:stokpile/utilities/components/entry_cards/animated_entry_card.dart';
import 'package:stokpile/utilities/components/entry_cards/builds/build_transitions.dart';

class DemolishEntryCard extends StatelessWidget {
  final Entry entry;
  final Animation<double> animation;

  const DemolishEntryCard({
    super.key,
    required this.entry,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return EntryCardTransition(
      animation: animation,
      transitionAlignment: 1,
      child: AnimatedEntryCard(
        key: ValueKey(entry.documentId),
        entry: entry,
        startExpanded: false,
        tapCallback: () {},
        animateWidget: false,
      ),
    );
  }
}

class BuildEntryCard extends StatelessWidget {
  const BuildEntryCard({
    super.key,
    required this.expandedList,
    required this.entry,
    required this.animation,
    required this.expanded,
    required this.animateWidget,
    required this.tapCallback,
  });

  final Map<String, Map<String, bool>> expandedList;
  final Entry entry;
  final Animation<double> animation;
  final bool expanded;
  final bool animateWidget;
  final void Function() tapCallback;

  @override
  Widget build(BuildContext context) {
    return EntryCardTransition(
      animation: animation,
      transitionAlignment: 1,
      child: AnimatedEntryCard(
        key: ValueKey(entry.documentId),
        entry: entry,
        startExpanded: expanded,
        animateWidget: animateWidget,
        tapCallback: () {
          tapCallback();
        },
      ),
    );
  }
}

void demolishRemovedEntryCard({
  required int listIndex,
  required Entry entry,
  required GlobalKey<AnimatedListState> animatedListKey,
}) {
  animatedListKey.currentState!.removeItem(
    listIndex,
    (context, animation) {
      return DemolishEntryCard(
        entry: entry,
        animation: animation,
      );
    },
  );
}

void entryCardTapCallback({
  required Map<String, Map<String, bool>> entryCardMetadata,
  required Entry entry,
}) {
  entryCardMetadata[entry.documentId!]!.update(
    entryCardIsExpandedFieldName,
    (value) => !value,
  );
}
