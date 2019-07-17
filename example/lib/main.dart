import 'package:flutter/material.dart';
import 'package:flotter/flotter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlotterAnimationController controller1 = FlotterAnimationController('assets/done.json', 'done1');
  FlotterAnimationController controller2 = FlotterAnimationController('assets/done.json', 'done2');
  FlotterAnimationController controller3 = FlotterAnimationController('assets/done.json', 'done3', isLoop: true);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flotter example'),
        ),
        body: Center(
          child:  Column(
            children: <Widget>[
              FlotterAnimation(controller1),
              Row(
                children: <Widget>[
                  FlatButton(
                    child: Text('start()'),
                    onPressed: () {
                      controller1.play();
                    }
                  ),
                  FlatButton(
                    child: Text('pause()'),
                    onPressed: () {
                      controller1.pause();
                    }
                  ),
                  FlatButton(
                    child: Text('stop()'),
                    onPressed: () {
                      controller1.stop();
                    }
                  ),
                ],
              ),
              FlotterAnimation(controller2),
              FlatButton(
                child: Text('reverse()'),
                onPressed: () {
                  controller2.reverse();
                }
              ),
              FlotterAnimation(controller3),
              Row(
                children: <Widget>[
                  FlatButton(
                    child: Text('start() in loop mode'),
                    onPressed: () {
                      controller3.play();
                    }
                  ),
                  FlatButton(
                    child: Text('pause() in loop mode'),
                    onPressed: () {
                      controller3.pause();
                    }
                  ),
                  FlatButton(
                    child: Text('stop() in loop mode'),
                    onPressed: () {
                      controller3.stop();
                    }
                  ),
                ],
              ),
            ]
          ),
        ),
      ),
    );
  }
}
