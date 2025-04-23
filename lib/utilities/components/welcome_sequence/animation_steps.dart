import 'package:stokpile/utilities/components/welcome_sequence/params/welcome_modal.dart';

abstract class AnimationSteps {
  final double xPosition;
  final double yPosition;
  final double rotation;
  final double scale;
  final String dialog;
  final Duration speed;
  final WelcomeModal? modal;

  AnimationSteps({
    required this.xPosition,
    required this.yPosition,
    required this.rotation,
    required this.scale,
    required this.dialog,
    required this.speed,
    required this.modal,
  });

  AnimationSteps getStep(int step);
}
