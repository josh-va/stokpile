import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/services/entries/entry.dart';
import 'package:stokpile/services/profile/bloc/profile_bloc.dart';
import 'package:stokpile/utilities/components/entry_cards/card_components/card_constants.dart';
import 'package:stokpile/utilities/components/entry_cards/card_components/card_edit_button.dart';
import 'package:stokpile/utilities/components/entry_cards/card_components/card_icon.dart';
import 'package:stokpile/utilities/components/entry_cards/card_components/card_note.dart';
import 'package:stokpile/utilities/components/entry_cards/card_components/card_timestamp.dart';
import 'package:stokpile/utilities/components/entry_cards/card_components/card_title.dart';
import 'package:stokpile/utilities/components/entry_cards/card_components/card_value.dart';

class ExpandedEntryCard extends StatefulWidget {
  final Entry entry;
  final bool animateWidget;
  final void Function() deleteCallback;

  const ExpandedEntryCard({
    super.key,
    required this.entry,
    required this.animateWidget,
    required this.deleteCallback,
  });

  @override
  State<ExpandedEntryCard> createState() => _ExpandedEntryCardState();
}

class _ExpandedEntryCardState extends State<ExpandedEntryCard> {
  List<Timer?> timers = List.filled(4, null);
  List<double> widgetOpacity = List.filled(4, 0.0);
  List<double> delayMultiplier = List.generate(4, (index) => 1 + index * 0.2);

  @override
  void initState() {
    if (widget.animateWidget) {
      for (int i = 0; i < delayMultiplier.length; i++) {
        fadeInWidget(i, delayMultiplier[i]);
      }
    } else {
      widgetOpacity = List.filled(4, 1.0);
    }
    super.initState();
  }

  void fadeInWidget(int i, double delayMultiplier) {
    timers[i]?.cancel();
    timers[i] = Timer(
      delayDuration * delayMultiplier,
      () {
        if (!mounted) return;
        setState(() {
          widgetOpacity[i] = 1.0;
        });
      },
    );
  }

  @override
  void dispose() {
    for (var timer in timers) {
      timer?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = context.read<ProfileBloc>().state.profile!.uid;
    return ListTile(
      leading: CardIcon(
        widgetOpacity: widgetOpacity[0],
        type: widget.entry.type,
      ),
      isThreeLine: true,
      titleAlignment: ListTileTitleAlignment.center,
      minVerticalPadding: 10,
      title: CardTitle(
        widgetOpacity: widgetOpacity[0],
        title: widget.entry.title,
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardValue(
            widgetOpacity: widgetOpacity[1],
            value: widget.entry.value,
          ),
          CardTimestamp(
            widgetOpacity: widgetOpacity[2],
            timestamp: widget.entry.timestamp,
          ),
          CardNote(
            widgetOpacity: widgetOpacity[3],
            note: widget.entry.note,
          )
        ],
      ),
      trailing: EditButton(
        widgetOpacity: widgetOpacity[0],
        entry: widget.entry,
        deleteCallback: widget.deleteCallback,
        uid: uid,
      ),
    );
  }
}
