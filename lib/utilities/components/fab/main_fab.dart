import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/constants/cloud_storage_constants.dart';
import 'package:stokpile/services/cloud/favorite.dart';
import 'package:stokpile/services/profile/bloc/profile_bloc.dart';
import 'package:stokpile/services/profile/profile.dart';
import 'package:stokpile/utilities/components/fab/fab_body.dart';
import 'package:stokpile/utilities/components/fab/fab_methods.dart';

class MainFab extends StatelessWidget {
  final String type;
  const MainFab({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is! ProfileStateLoggedIn) {
          throw Exception('not in correct state');
        }
        final Profile profile = state.getActiveProfile;
        final Favorite fav =
            type == saveEntryType ? state.favSave : state.favSpend;
        return GestureDetector(
          onLongPress: () async {
            fabLongTapBehavior(
              context: context,
              fav: fav,
              profile: profile,
            );
          },
          child: FloatingActionButton.large(
            heroTag: type,
            onPressed: () async {
              fabTapBehavior(
                context: context,
                fav: fav,
                profile: profile,
              );
            },
            shape: const CircleBorder(),
            backgroundColor: fabColor(type, context),
            child: FabBodyIcon(type: type),
          ),
        );
      },
    );
  }
}
