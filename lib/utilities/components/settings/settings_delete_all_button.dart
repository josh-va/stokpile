import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/services/entries/bloc/entries_bloc.dart';
import 'package:stokpile/utilities/dialogs/delete_all_dialog.dart';

class DeleteAllEntriesButton extends StatelessWidget {
  const DeleteAllEntriesButton(
    this.uid, {
    super.key,
  });
  final String uid;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          final bool proceed = await showDeleteAllDialog(context);
          if (proceed && context.mounted) {
            context.read<EntriesBloc>().add(EntriesEventDeleteAll(uid));
          }
        },
        child: Text(
          'Clear All Entries?',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ));
  }
}
