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
  FlotterAnimationController controller3 = FlotterAnimationController('assets/done.json', 'done3', loopMode: LottieLoopMode.loop);

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
              Container(
                width: 100.0,
                height: 100.0,

                child: FlotterAnimation(controller1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: <Widget>[
                  FlatButton(
                    child: Text('start()'),
                    onPressed: () {
                      controller1.playFrom(1.0, 0, FlotterLoopMode.autoReverseLoop);
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
              Container(
                width: 50.0,
                height: 50.0,

                child: FlotterAnimation(controller2),
              ),
              FlatButton(
                child: Text('reverse()'),
                onPressed: () {
                  controller2.reverse();
                }
              ),
              Container(
                width: 50.0,
                height: 50.0,

                child: FlotterAnimation(controller3),
              ),
              Text('LOOP MODE'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  FlatButton(
                    child: Text('start()'),
                    onPressed: () {
                      controller3.play();
                    }
                  ),
                  FlatButton(
                    child: Text('pause()'),
                    onPressed: () {
                      controller3.pause();
                    }
                  ),
                  FlatButton(
                    child: Text('stop()'),
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
