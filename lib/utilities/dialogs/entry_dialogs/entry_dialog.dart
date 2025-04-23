import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/constants/cloud_storage_constants.dart';
import 'package:stokpile/enums/entry_type_enum.dart';
import 'package:stokpile/services/entries/entry.dart';
import 'package:stokpile/services/profile/bloc/profile_bloc.dart';
import 'package:stokpile/utilities/dialogs/delete_dialog.dart';
import 'package:stokpile/utilities/dialogs/entry_dialogs/dialog_line_date.dart';
import 'package:stokpile/utilities/dialogs/entry_dialogs/dialog_line_text.dart';
import 'package:stokpile/utilities/dialogs/entry_dialogs/dialog_line_time.dart';
import 'package:stokpile/utilities/dialogs/generic_dialog.dart';
import 'package:stokpile/utilities/formatters/datetime_formatter.dart';

TextEditingController _titleFieldController = TextEditingController();
TextEditingController _valueFieldController = TextEditingController();
TextEditingController _noteFieldController = TextEditingController();
TextEditingController _dateFieldController = TextEditingController();
TextEditingController _timeFieldController = TextEditingController();

Future<Entry?> showEntryDialog(
  BuildContext context, {
  required Entry entry,
}) async {
  final newEntry = entry.documentId == null ? true : false;
  final heading = newEntry
      ? "New ${entry.type.name} entry"
      : 'Edit your ${entry.type.name} entry';

  final proceed = await showGenericDialog<String>(
    context: context,
    title: heading,
    content: EntryContents(
      context: context,
      entry: entry,
    ),
    optionsBuilder: () => {
      'Cancel': 'cancel',
      'Save': 'save',
    },
    deleteWidget: newEntry ? false : true,
  );

  final title = _titleFieldController.text;
  final value = num.tryParse(_valueFieldController.text) ?? 0;
  final date = dateFromFormattedString(date: _dateFieldController.text);
  final time = timeFromFormattedString(time: _timeFieldController.text);
  final completeDate = completeDateTimeFromDateAndTime(
    date: date,
    time: time,
  );
  final note = _noteFieldController.text;
  final sec = entry.timestamp.toDate().second;
  final timestamp =
      Timestamp.fromDate(completeDate.add(Duration(seconds: sec)));

  if (proceed == saveEntryType && context.mounted) {
    return Entry(
      documentId: entry.documentId,
      title: title,
      value: value,
      timestamp: timestamp,
      type: entry.type,
      note: note,
    );
  } else if (proceed == deleteEntryType && context.mounted) {
    final bool confirm = await showDeleteDialog(context);
    if (confirm) {
      return Entry(
        documentId: entry.documentId,
        title: title,
        value: value,
        timestamp: timestamp,
        type: EntryType.delete,
        note: note,
      );
    } else {
      return null;
    }
  } else {
    return null;
  }
}

class EntryContents extends StatelessWidget {
  const EntryContents({
    required BuildContext context,
    required this.entry,
    super.key,
  });
  final Entry entry;

  @override
  Widget build(BuildContext context) {
    final showNote = context.read<ProfileBloc>().state.profile!.notes;
    _titleFieldController.text = entry.title;
    _valueFieldController.text = entry.value.toStringAsFixed(2);
    _noteFieldController.text = entry.note ?? '';
    DateTime now = entry.timestamp.toDate();
    _dateFieldController.text = toFormattedDate(date: now);
    _timeFieldController.text = toFormattedTime(date: now);

    late Color iconColor;

    if (entry.type == EntryType.save && context.mounted) {
      iconColor = Theme.of(context).colorScheme.onTertiaryContainer;
    } else if (entry.type == EntryType.spend && context.mounted) {
      iconColor = Theme.of(context).colorScheme.onPrimaryContainer;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DialogLineText(
          iconColor: iconColor,
          controller: _titleFieldController,
          hintText: 'What was it?',
          iconData: Icons.title_rounded,
        ),
        DialogLineText(
          iconColor: iconColor,
          controller: _valueFieldController,
          hintText: 'How much was it?',
          iconData: Icons.attach_money_rounded,
        ),
        DialogLineCalendar(
          iconColor: iconColor,
          controller: _dateFieldController,
        ),
        DialogLineTime(
          iconColor: iconColor,
          controller: _timeFieldController,
        ),
        if (showNote || entry.note != '')
          DialogLineText(
            iconColor: iconColor,
            controller: _noteFieldController,
            hintText: 'Add a note to the entry?',
            iconData: Icons.notes_rounded,
          ),
      ],
    );
  }
}
