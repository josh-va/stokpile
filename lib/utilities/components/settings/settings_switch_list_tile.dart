import 'package:flutter/material.dart';

class SettingSwitchListTile extends StatefulWidget {
  final Map settings;
  final bool toggle;
  final String uid;

  const SettingSwitchListTile({
    super.key,
    required this.settings,
    required this.toggle,
    required this.uid,
  });

  @override
  State<SettingSwitchListTile> createState() => SettingSwitchListTileState();
}

class SettingSwitchListTileState extends State<SettingSwitchListTile> {
  final Duration duration = const Duration(milliseconds: 400);
  late bool toggle;
  bool enabled = true;

  @override
  void initState() {
    toggle = widget.toggle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: title(),
      subtitle: subtitle(),
      value: toggle,
      inactiveTrackColor: Colors.transparent,
      secondary: icon(),
      onChanged: (value) async {
        onToggle(value);
      },
    );
  }

  void onToggle(bool value) {
    if (enabled) {
      widget.settings['tapCallback'](value);
      enabled = false;
      toggle = value;
      Future.delayed(
        const Duration(milliseconds: 150),
        () {
          setState(() {
            enabled = true;
          });
        },
      );
    } else {
      null;
    }
  }

  AnimatedSwitcher icon() {
    return AnimatedSwitcher(
      duration: duration,
      child: Icon(
        widget.settings['icon'],
      ),
    );
  }

  Text title() {
    return Text(
      widget.settings['title'],
      style: const TextStyle(fontSize: 16.0),
    );
  }

  Text? subtitle() {
    if (widget.settings['subtitle'] == null) return null;
    return Text(widget.settings['subtitle']);
  }
}
