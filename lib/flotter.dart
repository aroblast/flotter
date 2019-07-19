import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'src/animationController.dart';
export 'src/animationController.dart';

class FlotterAnimation extends StatelessWidget {
  FlotterAnimation(this.controller, {
    this.height = double.infinity,
    this.width = double.infinity,
    this.playAtInit = false
  });

  // Parameters
  final FlotterAnimationController controller;
  final double height;
  final double width;
  final bool playAtInit;

  @override
  Widget build(BuildContext context) {
    if (!controller.isInitialized) {
      controller.init().then((result) {
        if (playAtInit) controller.play();
      });
    }

    // UIKitView parameters
    Map<String, String> creationParamsMap = {};
    creationParamsMap['animationId'] = controller.animationId;
    creationParamsMap['animationData'] = controller.animationData;

    if (Platform.isIOS)
      return Container(
        width: width,
        height: height,
        
        child: UiKitView(
          viewType: 'FlotterAnimation',
          creationParams: creationParamsMap,
          creationParamsCodec: StandardMessageCodec(),
          onPlatformViewCreated: null
        ),
      );
    else
      return Text('Not available on android yet.');
  }
}
