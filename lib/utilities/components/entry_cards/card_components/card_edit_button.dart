import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/enums/entry_type_enum.dart';
import 'package:stokpile/services/entries/bloc/entries_bloc.dart';
import 'package:stokpile/services/entries/entry.dart';
import 'package:stokpile/utilities/components/entry_cards/card_components/card_constants.dart';
import 'package:stokpile/utilities/dialogs/entry_dialogs/entry_dialog.dart';

class EditButton extends StatelessWidget {
  const EditButton({
    super.key,
    required this.widgetOpacity,
    required this.entry,
    required this.deleteCallback,
    required this.uid,
  });

  final double widgetOpacity;
  final Function deleteCallback;
  final Entry entry;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: animationDuration,
      opacity: widgetOpacity,
      child: IconButton(
        onPressed: () async {
          final editedEntry = await showEntryDialog(
            context,
            entry: entry,
          );
          if (editedEntry != null && context.mounted) {
            context.read<EntriesBloc>().add(EntriesEventUpdateEntry(
                  entry: editedEntry,
                  uid: uid,
                ));
            if (editedEntry.type == EntryType.delete) {
              deleteCallback();
            }
          }
        },
        icon: const Icon(Icons.edit),
      ),
    );
  }
}
