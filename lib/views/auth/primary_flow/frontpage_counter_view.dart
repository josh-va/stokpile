import 'package:flutter/material.dart';
import 'package:stokpile/services/profile/profile.dart';
import 'package:stokpile/utilities/components/ctotal_counter/ctotal_flip_counter.dart';

class FrontPageCounter extends StatelessWidget {
  final Profile profile;
  const FrontPageCounter({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text("Hey ${profile.name}! \n You've stokpiled...",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
              )),
        ),
        Center(
          child: CtotalFlipCounter(
            uid: profile.uid,
          ),
        ),
      ],
    );
  }
}
