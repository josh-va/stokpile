import 'package:flutter/material.dart';
import 'package:stokpile/constants/user_setup_constants.dart';

class UserSetupName extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function(String? name) onSaved;

  const UserSetupName({
    required this.formKey,
    required this.onSaved,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: TextFormField(
            decoration: const InputDecoration(labelText: nameFormHintText),
            textCapitalization: TextCapitalization.words,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return nameFormErrorText;
              } else {
                return null;
              }
            },
            onSaved: (value) => onSaved(value),
          ),
        ),
      ),
    );
  }
}
