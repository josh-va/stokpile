import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/enums/entry_type_enum.dart';
import 'package:stokpile/services/cloud/favorite.dart';
import 'package:stokpile/services/entries/bloc/entries_bloc.dart';
import 'package:stokpile/services/entries/entry.dart';
import 'package:stokpile/services/profile/profile.dart';
import 'package:stokpile/utilities/dialogs/add_fav_dialog.dart';
import 'package:stokpile/utilities/dialogs/entry_dialogs/entry_dialog.dart';
import 'package:stokpile/utilities/dialogs/error_dialog.dart';
import 'package:stokpile/utilities/dialogs/generic_dialog.dart';

const String notEnoughBanked =
    "You don't have enough banked to cash in for that!";
const String overdrawTitle = "You're about to overdraw!";
const String overdrawFalseOption = "Nah";
const String overdrawTrueOption = "I'm sure";

String overdrawBody(
  num newCTotal,
) {
  final cleanCtotal = newCTotal.abs().toStringAsFixed(2);
  return "Are you sure that you want to overdraw? \n \nYou'll be \$$cleanCtotal in the red!";
}

void addEntry({
  required BuildContext context,
  required Entry entry,
  required Profile profile,
}) {
  context.read<EntriesBloc>().add(EntriesEventAddEntry(
        entry: entry,
        uid: profile.uid,
      ));
}

Future<bool> checkValidEntry({
  required Entry entry,
  required Profile profile,
  required BuildContext context,
}) async {
  final value = entry.type == EntryType.save ? entry.value : -entry.value;
  final ctotal = context.read<EntriesBloc>().state.ctotal;
  final newCTotal = ctotal + value;
  late bool proceed;
  if (entry.type == EntryType.save) {
    proceed = true;
  } else if (newCTotal < 0 && profile.overdrawing == false && context.mounted) {
    await showErrorDialog(
      context,
      errorText: notEnoughBanked,
    );
    proceed = false;
  } else if (newCTotal < 0 && context.mounted) {
    proceed = await showGenericDialog(
      context: context,
      title: overdrawTitle,
      content: Text(overdrawBody(newCTotal)),
      optionsBuilder: () => {
        overdrawFalseOption: false,
        overdrawTrueOption: true,
      },
    ).then((value) => value ?? false);
  } else {
    proceed = true;
  }
  return proceed;
}

fabLongTapBehavior({
  required BuildContext context,
  required Favorite fav,
  required Profile profile,
}) async {
  if (context.mounted) {
    final entry = await showEntryDialog(
      context,
      entry: Entry.fromFavorite(fav),
    );
    if (entry == null) return;
    if (context.mounted) {
      final proceed = await checkValidEntry(
        entry: entry,
        profile: profile,
        context: context,
      );
      if (proceed && context.mounted) {
        addEntry(
          context: context,
          entry: entry,
          profile: profile,
        );
      }
    }
  }
}

fabTapBehavior({
  required BuildContext context,
  required Favorite fav,
  required Profile profile,
}) async {
  final entry = Entry.fromFavorite(fav);
  final bool favPrompt = await showAddFavDialog(
    context,
    entry: entry,
  );
  if (!favPrompt) return;
  if (context.mounted) {
    final proceed = await checkValidEntry(
      entry: entry,
      profile: profile,
      context: context,
    );
    if (proceed && context.mounted) {
      addEntry(
        context: context,
        entry: entry,
        profile: profile,
      );
    }
  }
}
