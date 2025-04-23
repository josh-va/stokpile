import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stokpile/enums/entry_type_enum.dart';
import 'package:stokpile/services/cloud/favorite.dart';
import 'package:stokpile/services/profile/bloc/profile_bloc.dart';
import 'package:stokpile/utilities/components/charater/king.dart';
import 'package:stokpile/utilities/components/welcome_sequence/welcome_steps.dart';
import 'package:stokpile/utilities/components/auth_screen/empty_flex_space.dart';
import 'package:stokpile/utilities/charater_animations/character_animation.dart';
import 'package:stokpile/utilities/components/auth_screen/menu_background.dart';
import 'package:stokpile/utilities/dialogs/gui_input_dialog.dart';
import 'package:stokpile/views/auth/gui_auth/gui_main_menu_view.dart';

class GuiWelcomeView extends StatefulWidget {
  const GuiWelcomeView({super.key});

  @override
  State<GuiWelcomeView> createState() => _GuiWelcomeViewState();
}

class _GuiWelcomeViewState extends State<GuiWelcomeView>
    with SingleTickerProviderStateMixin {
  String name = "Friend";
  String saveTitle = "Save";
  String spendTitle = "Spend";
  num saveValue = 0;
  num spendValue = 0;

  bool modalVisible = false;

  int step = 1;

  WelcomeSteps welcomeSteps = WelcomeSteps();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(builder: (context, construction) {
        double screenWidth = construction.maxWidth;
        double screenHeight = construction.maxHeight;
        return Stack(
          fit: StackFit.expand,
          children: [
            MenuBackground(opacity: 0.2),
            CharacterAnimation(
              character: King(),
              step: step,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmptyFlexSpace(26),
                MenuLayout(
                  flex: 13,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (welcomeSteps.getStep(step).modal != null) {
                          _showModalPopup();
                        } else if (step == 20) {
                          final Favorite save = Favorite(
                            title: saveTitle,
                            value: saveValue,
                            type: EntryType.save,
                          );
                          final Favorite spend = Favorite(
                            title: spendTitle,
                            value: spendValue,
                            type: EntryType.spend,
                          );
                          context
                              .read<ProfileBloc>()
                              .add(ProfileEventSetUpProfile(
                                name: name,
                                save: save,
                                spend: spend,
                              ));
                        } else {
                          setState(() => step++);
                        }
                      },
                      child: ChatBox(welcomeSteps
                          .getStep(
                            step,
                            name: name,
                            saveTitle: saveTitle,
                            saveValue: saveValue,
                            spendTitle: spendTitle,
                            spendValue: spendValue,
                          )
                          .dialog),
                    ),
                  ],
                ),
                EmptyFlexSpace(1)
              ],
            )
          ],
        );
      }),
    );
  }

  void _showModalPopup() async {
    modalVisible = true;
    final input = await showGuiInputDialog(
      context,
      text: welcomeSteps.getStep(step).modal!.title,
      hintText: welcomeSteps.getStep(step).modal!.hintText,
    );
    switch (welcomeSteps.getStep(step).modal!.variable) {
      case 'name':
        name = input!;
      case 'saveTitle':
        saveTitle = input!;
      case 'saveValue':
        saveValue = double.parse(input!);
      case 'spendTitle':
        spendTitle = input!;
      case 'spendValue':
        spendValue = double.parse(input!);
        break;
      default:
    }

    modalVisible = false;
    setState(() => step++);
  }
}

class ChatBox extends StatelessWidget {
  const ChatBox(
    this.text, {
    super.key,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Material(
          elevation: 5,
          color: Theme.of(context).colorScheme.inverseSurface.withOpacity(0.9),
          borderRadius: const BorderRadius.all(
            Radius.elliptical(40, 20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(text,
                  textScaler: const TextScaler.linear(1.5),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.gloriaHallelujah(
                      color: Theme.of(context).colorScheme.onPrimary)),
            ),
          ),
        ),
      ),
    );
  }
}
