# flotter

Use Lottie animations on iOS.

### *Important note*

First of all, you must add this to your `info.plist` file in your iOS project in order to enable the animation views to work correctly:

```xml
<key>io.flutter.embedded_views_preview</key>
<true/>
```

## Getting started

This plugin allows the use of the `LOTAnimationView` on iOS using Flutter's `FlotterAnimation` class.

To add an animation to your application,you must first create a `FotterAnimationController`. It will hold your animation's informations, such as the path of the json file in your assets containing the animation, the name given to the animation, and a few other parameters:

```dart
var controller = FlotterAnimationController(
    animationFilePath,
    name,
    isLoop, // false by default
    autoReverse, // false by default
);
```

Then, you simply add the controller to an animation view like this:

```dart
var animation = FlotterAnimation(controller);
```

## Methods

Now, you can control your animation using:

### play()

```dart
controller.start()
```

### pause()

```dart
controller.pause()
```

### reverse()

```dart
controller.reverse()
```

### stop()

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
