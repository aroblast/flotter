import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flotter/flotter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlotterAnimationController controller = FlotterAnimationController('data', 'id');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            FlotterAnimation(controller),
            FlatButton(
              child: Text('test'),
              onPressed: () => controller.start(),
            )
          ]
        ),
      ),
    );
  }
}
