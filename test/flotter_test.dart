import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flotter/flotter.dart';

void main() {
  const MethodChannel channel = MethodChannel('flotter');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Flotter.platformVersion, '42');
  });
}
