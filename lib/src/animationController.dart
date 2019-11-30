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
  final List<double> loopMode;
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

  // ----------------
  // Playback methods
  // ----------------
  void play() {
    if (isInitialized) methodChannel.invokeMethod('play');
  }

  void playFrom(double from, double to, List<double> loopMode) {
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

  void setAnimationSpeed(double speed) {
    if (isInitialized) methodChannel.invokeMethod('setAnimationSpeed', { 'speed': speed });
  }
}

class FlotterLoopMode {
  static const List<double> autoReverse = [0, 0];
  static const List<double> loop = [1, 0];
  static const List<double> playOnce = [2, 0];
  static List<double> repeat(double n) { return [3, n]; }
  static List<double> repeatBackwards(double n) { return [4, n]; }
}
