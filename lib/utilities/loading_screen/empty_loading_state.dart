import 'package:flutter/material.dart';
import 'package:stokpile/utilities/dialogs/components/dialog_backdrop.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: [
      Image.asset(
        'assets/bg/menu_bg.png',
        fit: BoxFit.cover,
      ),
      DialogBackdrop(
        animation: kAlwaysCompleteAnimation,
        child: Center(
          child: SizedBox(
            height: 80,
            width: 80,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    ]));
  }
}
