import 'package:flutter/material.dart';
import 'package:stokpile/services/entries/entry.dart';
import 'package:stokpile/utilities/components/history_box/history_box_bg.dart';
import 'package:stokpile/utilities/components/history_box/history_box_contents.dart';
import 'package:stokpile/utilities/components/history_box/history_box_header.dart';
import 'package:stokpile/utilities/components/history_box/histoy_box_internal.dart';

class HistoryBox extends StatelessWidget {
  const HistoryBox({
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
    return HistoryBoxBg(
      child: HistoryBoxInternal(
        header: const HistoryBoxHeader(),
        contents: HistoryBoxContents(
          animatedListKey: animatedListKey,
          entriesCache: entriesCache,
          entryCardMetadata: entryCardMetadata,
        ),
      ),
    );
  }
}
