import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/services/profile/bloc/profile_bloc.dart';
import 'package:stokpile/utilities/components/settings/settings_bottom_sheet.dart';
import 'package:stokpile/utilities/components/settings/settings_switch_list_tile.dart';
import 'package:stokpile/utilities/components/settings/settings_appbar.dart';
import 'package:stokpile/utilities/components/settings/settings_list.dart';
import 'package:stokpile/utilities/components/settings/settings_tile_settings.dart';
import 'package:stokpile/utilities/components/settings/settings_theme_segment_button.dart';
import 'package:stokpile/utilities/loading_screen/empty_loading_state.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _overdrawing = false;
  bool _notes = true;

  @override
  void initState() {
    _overdrawing = context.read<ProfileBloc>().state.profile!.overdrawing;
    _notes = context.read<ProfileBloc>().state.profile!.notes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileStateLoggedIn) {
          final uid = state.profile!.uid;
          final currentName = state.profile!.name;
          return Scaffold(
            appBar: SettingsAppBar(currentName: currentName),
            body: SettingsList(
              children: [
                const ThemeSegmentedButton(),
                SettingSwitchListTile(
                  settings: overdrawingSetting(context),
                  toggle: _overdrawing,
                  uid: uid,
                ),
                SettingSwitchListTile(
                  settings: noteSetting(context),
                  toggle: _notes,
                  uid: uid,
                ),
              ],
            ),
            bottomSheet: SettingsBottomSheet(uid),
          );
        } else {
          return const LoadingState();
        }
      },
    );
  }
}
