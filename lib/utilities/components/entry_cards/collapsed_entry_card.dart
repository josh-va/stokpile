import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stokpile/enums/entry_type_enum.dart';
import 'package:stokpile/services/entries/entry.dart';
import 'package:stokpile/utilities/components/entry_cards/card_components/card_icon.dart';
import 'package:stokpile/utilities/components/entry_cards/card_components/card_title.dart';

class CollapsedEntryCard extends StatefulWidget {
  final Entry entry;
  final bool animateWidget;
  const CollapsedEntryCard({
    super.key,
    required this.entry,
    required this.animateWidget,
  });

  @override
  State<CollapsedEntryCard> createState() => _CollapsedEntryCardState();
}

class _CollapsedEntryCardState extends State<CollapsedEntryCard> {
  double widgetOpacity = 0.0;
  Duration delayDuration = const Duration(milliseconds: 200);
  Duration animationDuration = const Duration(milliseconds: 400);
  Timer? timer;

  @override
  void initState() {
    if (widget.animateWidget) {
      fadeInWidget();
    } else {
      widgetOpacity = 1.0;
    }
    super.initState();
  }

  Icon entryIcon() {
    if (widget.entry.type == EntryType.save) {
      return Icon(
        Icons.attach_money,
        color: Theme.of(context).colorScheme.onTertiaryContainer,
      );
    } else {
      return Icon(
        Icons.redeem,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      );
    }
  }

  void fadeInWidget() {
    timer?.cancel();
    timer = Timer(
      delayDuration,
      () {
        if (!mounted) return;
        setState(() {
          widgetOpacity = 1.0;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CardIcon(
          widgetOpacity: widgetOpacity,
          type: widget.entry.type,
        ),
        title: CardTitle(
          widgetOpacity: widgetOpacity,
          title: widget.entry.title,
        ));
  }
}
