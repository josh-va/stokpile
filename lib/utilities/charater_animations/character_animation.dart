import 'package:flutter/material.dart';
import 'package:stokpile/utilities/charater_animations/rotation_animation.dart';
import 'package:stokpile/utilities/charater_animations/scale_animation.dart';
import 'package:stokpile/utilities/charater_animations/position_animation.dart';
import 'package:stokpile/utilities/components/charater/character.dart';
import 'package:stokpile/utilities/components/welcome_sequence/welcome_steps.dart';

class CharacterAnimation extends StatefulWidget {
  const CharacterAnimation({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.step,
    required this.character,
  });

  final double screenWidth;
  final double screenHeight;
  final int step;
  final Character character;

  @override
  State<CharacterAnimation> createState() => _CharacterAnimationState();
}

class _CharacterAnimationState extends State<CharacterAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> rotationAnimation;
  late Animation<double> xPositionAnimation;
  late Animation<double> yPositionAnimation;
  late Animation<double> scaleAnimation;
  late AnimationController _idleController;
  late Animation<double> _idleScale;
  int previousStep = 0;
  late Character character;
  final dialogSteps = WelcomeSteps();

  @override
  void initState() {
    super.initState();
    character = widget.character;
    _controller = AnimationController(
      vsync: this,
      duration: _getAnimationSpeed(0),
    );
    rotationAnimation = _animationTween(
      begin: _getRotation(0),
      end: _getRotation(1),
    );
    xPositionAnimation = _animationTween(
      begin: _getXPosition(0),
      end: _getXPosition(1),
    );
    yPositionAnimation = _animationTween(
      begin: _getYPosition(0),
      end: _getYPosition(1),
    );
    scaleAnimation = _animationTween(
      begin: _getScale(0),
      end: _getScale(1),
    );
    _idleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _idleScale = Tween<double>(begin: -1.0, end: 1.0).animate(_idleController);
    _controller.forward();
  }

  Duration _getAnimationSpeed(int step) => dialogSteps.getStep(step).speed;

  @override
  void didUpdateWidget(CharacterAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.step != widget.step) {
      previousStep = oldWidget.step;
      _controller.duration = _getAnimationSpeed(widget.step);
      _updateAnimation();
    }
  }

  void _updateAnimation() {
    final int currentStep = widget.step;
    final double previousXPosition = _getXPosition(previousStep);
    final double newXPosition = _getXPosition(currentStep);
    final double previousYPosition = _getYPosition(previousStep);
    final double newYPosition = _getYPosition(currentStep);
    final double previousRotation = _getRotation(previousStep);
    final double newRotation = _getRotation(currentStep);
    final double previousScale = _getScale(previousStep);
    final double newScale = _getScale(currentStep);

    xPositionAnimation = _animationTween(
      begin: previousXPosition,
      end: newXPosition,
    );
    yPositionAnimation = _animationTween(
      begin: previousYPosition,
      end: newYPosition,
    );
    rotationAnimation = _animationTween(
      begin: previousRotation,
      end: newRotation,
    );
    scaleAnimation = _animationTween(
      begin: previousScale,
      end: newScale,
    );

    _controller.reset();
    _controller.forward();
  }

  double _getScale(int step) => dialogSteps.getStep(step).scale;
  double _getRotation(int step) => dialogSteps.getStep(step).rotation;
  double _getYPosition(int step) =>
      dialogSteps.getStep(step).yPosition * widget.screenHeight;
  double _getXPosition(int step) =>
      dialogSteps.getStep(step).xPosition * widget.screenWidth;

  Animation<double> _animationTween({
    required double begin,
    required double end,
  }) {
    return Tween<double>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _idleController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PositionAnimation(
      xPositionAnimation: xPositionAnimation,
      yPositionAnimation: yPositionAnimation,
      widget: RotationAnimation(
        rotationAnimation: rotationAnimation,
        pivotPoint: character.pivotPoint,
        widget: ScaleAnimation(
          scaleAnimation: scaleAnimation,
          widget: AnimatedBuilder(
              animation: _idleController,
              builder: (context, child) {
                final idleScaleEffect = 1 + (_idleScale.value * 0.02);
                return Transform.scale(
                  scale: idleScaleEffect,
                  child: child,
                );
              },
              child: character.image),
        ),
      ),
    );
  }
}
