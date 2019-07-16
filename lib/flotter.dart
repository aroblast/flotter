import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'src/animationController.dart';
export 'src/animationController.dart';


class FlotterAnimation extends StatelessWidget {
  FlotterAnimation(this.controller);

  // Parameters
  final FlotterAnimationController controller;
  
  @override
  Widget build(BuildContext context) {
    // UIKitView parameters
    Map<String, String> creationParamsMap = {};
    creationParamsMap['animationId'] = controller.animationId;
    creationParamsMap['animationData'] = controller.animationData;

    if (Platform.isIOS)
      return Container(
        width: 100.0,
        height: 100.0,

        child: UiKitView(
          viewType: 'FlotterAnimation',
          creationParams: creationParamsMap,
          creationParamsCodec: StandardMessageCodec(),
          onPlatformViewCreated: null,
        ),
      );
    else
      return Text('Not available on android yet.');
  }
}