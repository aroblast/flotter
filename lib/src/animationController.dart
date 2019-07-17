import 'package:flutter/services.dart';

class FlotterAnimationController {
  MethodChannel methodChannel;

  FlotterAnimationController(
    this.jsonFilePath,
    this.animationId, {
      this.isLoop = false,
      this.autoReverse = false
    }) {
    methodChannel = MethodChannel('flotter-' + animationId);
  }

  // Parameters
  final String animationId;
  final String jsonFilePath;
  final bool isLoop;
  final bool autoReverse;
  String animationData;
  bool isInitialized = false;
  

  void init() async {
    if (!isInitialized)
    {
      // Read json file
      animationData = await rootBundle.loadString(jsonFilePath);
      isInitialized = await methodChannel.invokeMethod('initialize', {
        'animationData': animationData,
        'isLoop': isLoop,
        'autoReverse': autoReverse,
      });
    }
  }

  void play() {
    if (isInitialized)
      methodChannel.invokeMethod('play');
  }

  void pause() {
    if (isInitialized)
      methodChannel.invokeMethod('pause');
  }

  void reverse() {
    if (isInitialized)
      methodChannel.invokeMethod('reverse');
  }

  void stop() {
    if (isInitialized)
      methodChannel.invokeMethod('stop');
  }
}