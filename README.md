# flotter

Use Lottie animations on iOS.

### *Important note*

First of all, you must add this to your `info.plist` file in your iOS project in order to enable the animation views to work correctly:

```xml
<key>io.flutter.embedded_views_preview</key>
<true/>
```

Then, you need to make sure that your iOS Podfile uses frameworks, to enable Swift compability. In your Podfile, add `use_frameworks!` like so:

```pod
target 'Runner' do
  use_frameworks!
```

Finally, as the iOS plugin is written in Swift, you must also specify the SWIFT_VERSION in your build settings, inside your XCode project. To do so, you must first:

##### 1. Add a new Swift file to your project inside the `Runner` project.

Open the project inside of XCode, and go to **File / New / File (⌘N)**. Choose **Swift file** and add it to the *Runner*.

##### 2. Create a new Objective C bridging header by choosing `Create bridging header` in the popup that opened.

After selecting the *Runner* in which you have to add the Swift file, a popup will open asking you if you want to create a bridging header. Simply choose **Create bridging header**.

##### 3. Set the *SWIFT_VERSION* to *Swift 5*.

In your *Runner* settings, go to **Build settings**, and set the SWIFT_VERSION to your convenience. *Flotter* is built in **Swift 5**, but you can **try** using an older version.

For more informations, please see [ko2ic tutorial](https://github.com/ko2ic/image_downloader/wiki#your-appdelegate-is-the-case-of-objective-c).

## Getting started

This plugin allows the use of the `LOTAnimationView` on iOS using Flutter's `FlotterAnimation` class.

To add an animation to your application,you must first create a `FotterAnimationController`. It will hold your animation's informations, such as the path of the json file in your assets containing the animation, the name given to the animation, and a few other parameters:

```dart
var controller = FlotterAnimationController(
    animationFilePath,
    name,
    loopMode, // FlotterLoopMode.playOnce by default
);
```

Then, you simply add the controller to an animation view like this:

```dart
var animation = FlotterAnimation(controller);
```

##Loop modes

The loop mode class is `FlotterLoopMode`, and is written like so:

```dart
class FlotterLoopMode {
  static const playOnce = 0;
  static const loop = 1;
  static const autoReverse = 2;
  static const autoReverseLoop = 3;
}
```

To indicate a loop mode, use either an integer (0 - 3), or `FlotterLoopMode.[loopMode]`.

## Methods

Now, you can control your animation using:

### play()

Play the animation entirely.

```dart
controller.play()
```

### playFrom(fromProgress, toProgress, loopMode)

Play from a percentage (0.0 - 1.0) to another with a loop mode specified.

```dart
controller.playFrom(
  fromProgress, // double
  toProgress, // double
  loopMode // LottieLoopMode (int)
)
```

### pause()

Pause the animation.

```dart
controller.pause()
```

### reverse()

Play the animation in reverse, from progress time 1.0 to 0.0.

```dart
controller.reverse()
```

### stop()

Reset the animation to progress time 0.0.

```dart
controller.stop()
```

## About

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
