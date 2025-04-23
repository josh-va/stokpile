import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stokpile/utilities/dialogs/components/dialog_backdrop.dart';
import 'package:stokpile/utilities/loading_screen/empty_loading_state.dart';
import 'package:stokpile/utilities/loading_screen/loading_screen_controller.dart';

class LoadingScreen {
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  LoadingScreen._sharedInstance();
  factory LoadingScreen() => _shared;

  LoadingScreenController? controller;

  void show({
    required BuildContext context,
    required String text,
  }) {
    if (controller?.update(text) ?? false) {
      return;
    } else {
      controller = showOverlay(
        context: context,
        text: text,
      );
    }
  }

  void hide() {
    controller?.close();
    controller = null;
  }

  LoadingScreenController showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final textController = StreamController<String>();
    textController.add(text);

    final state = Overlay.of(context);

    final overlay = OverlayEntry(
      builder: (context) {
        return Stack(children: const [
          LoadingState(),
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
        ]);
      },
    );

    state.insert(overlay);

    return LoadingScreenController(
      close: () {
        textController.close();
        overlay.remove();
        return true;
      },
      update: (text) {
        textController.add(text);
        return true;
      },
    );
  }
}
