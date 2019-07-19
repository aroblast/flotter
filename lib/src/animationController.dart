import 'package:flutter/services.dart';

class FlotterAnimationController {
  FlotterAnimationController(
    this.jsonFilePath,
    this.animationId, {
    this.loopMode = FlotterLoopMode.playOnce,
  }) : methodChannel = MethodChannel('flotter-' + animationId);

  // Parameters
  final MethodChannel methodChannel;
  final String animationId;
  final String jsonFilePath;
  final int loopMode;
  String animationData;
  bool isInitialized = false;

  Future<void> init() async {
    if (!isInitialized) {
      // Read json file
      animationData = await rootBundle.loadString(jsonFilePath);
      isInitialized = await methodChannel.invokeMethod('initialize', {
        'animationData': animationData,
        'loopMode': loopMode,
      });
    }
  }

  void play() {
    if (isInitialized) methodChannel.invokeMethod('play');
  }

  void playFrom(double from, double to, int loopMode) {
    if (isInitialized)
      methodChannel.invokeMethod('playFrom', {
        'from': from,
        'to': to,
        'loopMode': loopMode,
      });
  }

  void pause() {
    if (isInitialized) methodChannel.invokeMethod('pause');
  }

  void reverse() {
    if (isInitialized) methodChannel.invokeMethod('reverse');
  }

  void stop() {
    if (isInitialized) methodChannel.invokeMethod('stop');
  }
}

class FlotterLoopMode {
  static const playOnce = 0;
  static const loop = 1;
  static const autoReverse = 2;
  static const autoReverseLoop = 3;
}
