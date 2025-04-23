import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stokpile/services/auth/bloc/auth_bloc.dart';
import 'package:stokpile/utilities/components/auth_screen/empty_flex_space.dart';
import 'package:stokpile/utilities/components/auth_screen/menu_background.dart';

class GuiMainMenuView extends StatefulWidget {
  const GuiMainMenuView({super.key});

  @override
  State<GuiMainMenuView> createState() => _GuiMainMenuViewState();
}

class _GuiMainMenuViewState extends State<GuiMainMenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          MenuBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmptyFlexSpace(26),
              MenuLayout(
                flex: 13,
                children: mainMenuItems(),
              ),
              EmptyFlexSpace(1)
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> mainMenuItems() {
    return [
      MenuButton(
        "Let's get started!",
        () => anonymousLogin(),
      ),
      MenuButton(
        "Log in",
        () {},
      ),
    ];
  }

  void anonymousLogin() {
    final authBloc = context.read<AuthBloc>();
    return authBloc.add(const AuthEventLogInAnonymously());
  }
}

class MenuLayout extends StatelessWidget {
  const MenuLayout({
    required this.flex,
    required this.children,
    super.key,
  });
  final List<Widget> children;
  final int flex;
  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 13,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: children,
              ),
            )
          ],
        ));
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton(
    this.text,
    this.callback, {
    super.key,
  });
  final String text;
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Material(
          elevation: 5,
          color: Theme.of(context).colorScheme.inverseSurface.withOpacity(0.9),
          borderRadius: const BorderRadius.all(
            Radius.elliptical(40, 20),
          ),
          child: InkWell(
            splashColor: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.all(
              Radius.elliptical(40, 20),
            ),
            onTap: callback,
            child: Center(
              child: Text(text,
                  textScaler: const TextScaler.linear(1.5),
                  style: GoogleFonts.gloriaHallelujah(
                      color: Theme.of(context).colorScheme.onPrimary)),
            ),
          ),
        ),
      ),
    );
  }
}
