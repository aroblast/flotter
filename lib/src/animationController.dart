import 'package:flutter/services.dart';

class FlotterAnimationController {
  MethodChannel methodChannel;

  FlotterAnimationController(this.animationData, this.animationId) {
    methodChannel = MethodChannel('flotter-' + animationId);
  }

  // Parameters
  final String animationData;
  final String animationId;

  void start() {
    methodChannel.invokeMethod('start', { 'id': this.animationId });
  }

  void pause() {
    methodChannel.invokeMethod('pause', { 'id': this.animationId });
  }

  void reverse() {
    methodChannel.invokeMethod('reverse', { 'id': this.animationId });
  }

  void stop() {
    methodChannel.invokeMethod('stop', { 'id': this.animationId });
  }
}