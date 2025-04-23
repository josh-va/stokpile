import 'package:flutter/material.dart';
import 'package:stokpile/enums/entry_type_enum.dart';
import 'package:stokpile/services/entries/entry.dart';
import 'package:stokpile/utilities/components/entry_cards/collapsed_entry_card.dart';
import 'package:stokpile/utilities/components/entry_cards/expanded_entry_card.dart';

class CustomEntryCard extends StatefulWidget {
  final Entry entry;
  final bool? startExpanded;
  final bool? animateWidget;
  final void Function() tapCallback;

  const CustomEntryCard({
    super.key,
    required this.entry,
    this.startExpanded,
    this.animateWidget,
    required this.tapCallback,
  });

  @override
  State<CustomEntryCard> createState() => _CustomEntryCardState();
}

class _CustomEntryCardState extends State<CustomEntryCard> {
  late bool expanded;
  bool note = false;
  late bool animateWidget;

  @override
  void initState() {
    if (widget.entry.note != '' && widget.entry.note != null) {
      note = true;
    }
    expanded = widget.startExpanded ?? false;
    animateWidget = widget.animateWidget ?? true;
    super.initState();
  }

  void flipExpanded() {
    setState(
      () {
        animateWidget = true;
        expanded = !expanded;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    late Color color;

    if (widget.entry.type == EntryType.save) {
      color = colorScheme.tertiaryContainer;
    } else if (widget.entry.type == EntryType.spend) {
      color = colorScheme.primaryContainer;
    }

    if (widget.entry.note != '' && widget.entry.note != null) {
      note = true;
    } else {
      note = false;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.fromLTRB(4, 0, 4, 8),
      height: note
          ? expanded
              ? 104
              : 56
          : expanded
              ? 84
              : 56,
      curve: Curves.easeInOut,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Material(
          clipBehavior: Clip.antiAlias,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(20, 10)),
          ),
          color: color.withOpacity(0.8),
          child: InkWell(
            splashFactory: InkRipple.splashFactory,
            onTap: () {
              flipExpanded();
              widget.tapCallback();
            },
            child: expanded
                ? ExpandedEntryCard(
                    entry: widget.entry,
                    animateWidget: animateWidget,
                    deleteCallback: () {
                      flipExpanded();
                    },
                  )
                : CollapsedEntryCard(
                    entry: widget.entry,
                    animateWidget: animateWidget,
                  ),
          ),
        ),
      ),
    );
  }
}
