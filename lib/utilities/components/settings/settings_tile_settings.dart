import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/constants/cloud_storage_constants.dart';
import 'package:stokpile/services/profile/bloc/profile_bloc.dart';

Map<String, dynamic> overdrawingSetting(BuildContext context) {
  return {
    'title': 'Overdrawing',
    'subtitle': 'Allows your balance to go below 0',
    'icon': Icons.attach_money_rounded,
    'tapCallback': (bool toggle) =>
        context.read<ProfileBloc>().add(ProfileEventSettingChange(
              setting: overdrawingSettingFieldName,
              value: toggle,
            ))
  };
}

Map<String, dynamic> noteSetting(BuildContext context) {
  return {
    'title': 'Entry Notes',
    'subtitle': 'Allows custom notes to be added',
    'icon': Icons.notes_rounded,
    'tapCallback': (bool toggle) =>
        context.read<ProfileBloc>().add(ProfileEventSettingChange(
              setting: notesSettingFieldName,
              value: toggle,
            ))
  };
}
