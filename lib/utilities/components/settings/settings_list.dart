import 'package:flutter/material.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({
    required this.children,
    super.key,
  });
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: ShaderMask(
          shaderCallback: (bounds) {
            return const LinearGradient(
                    stops: [0, 0.01],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black])
                .createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: ListView(
            children: children,
          ),
        ),
      ),
    );
  }
}
