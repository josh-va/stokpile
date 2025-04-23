import 'package:flutter/material.dart';
import 'package:stokpile/services/entries/entry.dart';
import 'package:stokpile/utilities/components/entry_cards/custom_entry_card.dart';

class AnimatedEntryCard extends StatefulWidget {
  final Entry entry;
  final bool? startExpanded;
  final bool? animateWidget;
  final void Function() tapCallback;

  const AnimatedEntryCard({
    super.key,
    required this.entry,
    this.startExpanded,
    this.animateWidget,
    required this.tapCallback,
  });

  @override
  State<AnimatedEntryCard> createState() => _AnimatedEntryCardState();
}

class _AnimatedEntryCardState extends State<AnimatedEntryCard> {
  @override
  Widget build(BuildContext context) {
    const animationDuration = Duration(milliseconds: 400);

    return AnimatedSwitcher(
        duration: animationDuration,
        transitionBuilder: (child, animation) {
          return SizeTransition(
            sizeFactor: animation,
            axisAlignment: -1,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        child: CustomEntryCard(
          entry: widget.entry,
          animateWidget: widget.animateWidget,
          startExpanded: widget.startExpanded,
          tapCallback: widget.tapCallback,
        ));
  }
}
