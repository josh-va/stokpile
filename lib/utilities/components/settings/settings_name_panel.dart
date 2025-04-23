import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/services/profile/bloc/profile_bloc.dart';
import 'package:stokpile/utilities/dialogs/input_dialog.dart';

class NamePanel extends StatelessWidget {
  const NamePanel(
    this.currentName, {
    super.key,
  });

  final String currentName;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: namePanelBackground(context),
        child: ListTile(
          title: Text(
            currentName,
            textAlign: TextAlign.center,
            textScaler: const TextScaler.linear(1.2),
          ),
          onTap: () async {
            await displayNameChangeDialog(context);
          },
        ));
  }

  BoxDecoration namePanelBackground(BuildContext context) {
    return BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.surfaceContainer);
  }

  Future<void> displayNameChangeDialog(BuildContext context) async {
    String? newName = await showInputDialog(
      context,
      text: "What's your name?",
      hintText: currentName,
    );
    if (newName != null && context.mounted) {
      context.read<ProfileBloc>().add(ProfileEventNameChange(newName));
    }
  }
}
