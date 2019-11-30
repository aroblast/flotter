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
  FlotterAnimationController controller3 = FlotterAnimationController('assets/done.json', 'done3', loopMode: FlotterLoopMode.loop);

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
              FlotterAnimation(
                controller1,
                
                width: 100.0,
                height: 100.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: <Widget>[
                  FlatButton(
                    child: Text('play()'),
                    onPressed: () {
                      controller1.play();
                    }
                  ),
                  FlatButton(
                    child: Text('playFrom()'),
                    onPressed: () {
                      controller1.playFrom(1.0, 0, FlotterLoopMode.autoReverse);
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
              
              FlotterAnimation(
                controller2,
                
                width: 100.0,
                height: 100.0,
              ),

              FlatButton(
                child: Text('reverse()'),
                onPressed: () {
                  controller2.reverse();
                }
              ),

              FlotterAnimation(
                controller3,
                
                width: 100.0,
                height: 100.0,
              ),

              Text('LOOP MODE'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  FlatButton(
                    child: Text('play()'),
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
