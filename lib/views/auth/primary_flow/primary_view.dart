//Background image ref "https://www.freepik.com/free-vector/hand-drawn-landscape_1008068.htm"

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/services/profile/bloc/profile_bloc.dart';
import 'package:stokpile/utilities/components/fab/twin_fabs.dart';
import 'package:stokpile/utilities/components/primary/primary_appbar.dart';
import 'package:stokpile/utilities/components/primary/primary_background.dart';
import 'package:stokpile/utilities/components/settings/settings_button.dart';
import 'package:stokpile/utilities/loading_screen/empty_loading_state.dart';
import 'package:stokpile/views/auth/primary_flow/history_view.dart';
import 'package:stokpile/views/auth/primary_flow/frontpage_counter_view.dart';

class PrimaryView extends StatefulWidget {
  const PrimaryView({super.key});

  @override
  State<PrimaryView> createState() => _PrimaryViewState();
}

class _PrimaryViewState extends State<PrimaryView> {
  final _pageViewController = PageController(initialPage: 1);
  double _currentPage = 1;

  @override
  void initState() {
    _pageViewController.addListener(() {
      setState(() {
        _currentPage = _pageViewController.page!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileStateLoggedIn) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            body: primaryUiStack(state),
            floatingActionButton: const TwinFabs(),
            appBar: const PrimaryAppBar([
              SettingsButton(),
            ]),
            extendBodyBehindAppBar: true,
            bottomNavigationBar: const BottomAppBar(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        } else {
          return const LoadingState();
        }
      },
    );
  }

  Stack primaryUiStack(ProfileStateLoggedIn state) {
    return Stack(
      children: [
        animatedBackground(),
        PageView(
          controller: _pageViewController,
          children: [
            const HistoryView(),
            FrontPageCounter(profile: state.profile!),
          ],
        ),
      ],
    );
  }

  AnimatedPositioned animatedBackground() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 0),
      right: getBackgroundRightOffset(),
      top: 0,
      bottom: 0,
      width: MediaQuery.of(context).size.width * 1.5,
      child: const PrimaryBackground(),
    );
  }

  double getBackgroundRightOffset() {
    return (MediaQuery.of(context).size.width * (_currentPage * 0.5)) -
        MediaQuery.of(context).size.width / 2;
  }
}
