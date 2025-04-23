import 'dart:math';

import 'package:stokpile/utilities/components/welcome_sequence/animation_steps.dart';
import 'package:stokpile/utilities/components/welcome_sequence/params/welcome_speed.dart';
import 'package:stokpile/utilities/components/welcome_sequence/params/welcome_modal_list.dart';
import 'package:stokpile/utilities/components/welcome_sequence/params/welcome_position.dart';
import 'package:stokpile/utilities/components/welcome_sequence/params/welcome_rotation.dart';
import 'package:stokpile/utilities/components/welcome_sequence/params/welcome_scale.dart';
import 'package:stokpile/utilities/components/welcome_sequence/params/welcome_script.dart';

class WelcomeSteps extends AnimationSteps {
  WelcomeSteps({
    super.xPosition = 0,
    super.yPosition = 0,
    super.rotation = 0,
    super.scale = 1,
    super.dialog = '',
    super.speed = const Duration(milliseconds: 1000),
    super.modal,
  });

  @override
  WelcomeSteps getStep(
    int step, {
    String name = 'Friend',
    String saveTitle = 'Save',
    num saveValue = 0,
    String spendTitle = 'Spend',
    num spendValue = 0,
  }) {
    return WelcomeSteps(
      xPosition: welcomePosition[step]['x']!,
      yPosition: welcomePosition[step]['y']!,
      rotation: welcomeRotation[step] * pi / 180,
      scale: welcomeScale[step],
      dialog: welcomeScript(
        name: name,
        saveTitle: saveTitle,
        saveValue: saveValue,
        spendTitle: spendTitle,
        spendValue: spendValue,
      )[step],
      speed: Duration(milliseconds: welcomeSpeed[step]),
      modal: welcomeModalList[step],
    );
  }
}
