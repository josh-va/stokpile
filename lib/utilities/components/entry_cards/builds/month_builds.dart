import 'package:flutter/material.dart';
import 'package:stokpile/utilities/components/entry_cards/builds/build_transitions.dart';

class BuildMonth extends StatelessWidget {
  const BuildMonth({
    super.key,
    required this.month,
    required this.animation,
  });

  final String month;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return EntryCardTransition(
      animation: animation,
      transitionAlignment: topAlign,
      child: Padding(
        key: ValueKey(month),
        padding: padding,
        child: Text(month),
      ),
    );
  }
}

class DemolishMonth extends StatelessWidget {
  const DemolishMonth({
    super.key,
    required this.month,
    required this.animation,
  });

  final String month;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return EntryCardTransition(
      animation: animation,
      transitionAlignment: topAlign,
      child: Padding(
        key: ValueKey(month),
        padding: padding,
        child: Text(month),
      ),
    );
  }
}

void demolishEmptyMonth(
  int listIndex,
  Iterable<dynamic> listDiff,
  GlobalKey<AnimatedListState> animatedListKey,
) {
  animatedListKey.currentState!.removeItem(
    listIndex - 1,
    (
      context,
      animation,
    ) {
      return DemolishMonth(
        month: listDiff.first,
        animation: animation,
      );
    },
  );
}
