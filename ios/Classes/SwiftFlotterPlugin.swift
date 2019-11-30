import Flutter
import Lottie

public class SwiftFlotterPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        registrar.register(FlotterAnimationViewFactory(registrar.messenger()), withId: "FlotterAnimation")
    }
}

public class FlotterAnimationViewFactory: NSObject, FlutterPlatformViewFactory {
    var messenger: (NSObjectProtocol & FlutterBinaryMessenger)?
    
    init(_ messenger: (NSObjectProtocol & FlutterBinaryMessenger)?) {
        self.messenger = messenger!
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
    
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return FlotterAnimationView(frame, viewId: viewId, args: args, binaryMessenger: messenger)
    }
}

public class FlotterAnimationView: NSObject, FlutterPlatformView {
    let frame: CGRect
    let viewId: Int64
    let animationId: String
    let methodChannel: FlutterMethodChannel
    let animationView: AnimationView
    var isReady = false
    
    init(_ frame: CGRect, viewId: Int64, args: Any?, binaryMessenger messenger: (NSObjectProtocol & FlutterBinaryMessenger)?) {
        self.frame = frame
        self.viewId = viewId
        
        // Parse args
        let arguments = args as? Dictionary<String, Any>
        
        if (arguments != nil) {
            animationId = arguments?["animationId"] as! String
        }
        else {
            animationId = "nil"
        }
        
        // Initialize methodChannel and animationView
        methodChannel = FlutterMethodChannel(name: "flotter-\(animationId)", binaryMessenger: messenger!)
        animationView = AnimationView(frame: frame)
        
        super.init()
        
        // Add handle call method
        methodChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            let args = call.arguments as? Dictionary<String, Any>
            
            switch (call.method)
            {
            case "initialize":
                self!.initialize(
                    args!["animationData"] as! String,
                    args!["loopMode"] as! [CGFloat]
                )
                result(self!.isReady)
                break;
                
            case "play":
                self!.play()
                break;
                
            case "playFrom":
                self!.playFrom(
                    fromProgress: args!["from"] as! CGFloat,
                    toProgress: args!["to"] as! CGFloat,
                    loopMode: args!["loopMode"] as! [CGFloat]
                )
                break;
                
            case "pause":
                self!.pause()
                break;
                
            case "reverse":
                self!.reverse()
                break;
                
            case "stop":
                self!.stop()
                break;
                
            case "setAnimationSpeed":
                self!.setAnimationSpeed(speed: args!["speed"] as! CGFloat)
                break;
                
            default:
                result(FlutterMethodNotImplemented)
            }
        })
    }
    
    public func view() -> UIView {
        return animationView;
    }
    
    // ------------------
    // State functions
    // ------------------
    private func initialize(
        _ animationData: String,
        _ loopMode: [CGFloat]
    ) {
        if (!isReady) {
            // Try convert json string to json object
            do {
                // Set animationView
                let animation = try JSONDecoder().decode(Animation.self, from: animationData.data(using: .utf8)!)
                let loopMode: LottieLoopMode = toLottieLoopMode(loopMode: loopMode)
                
                animationView.animation = animation
                animationView.loopMode = loopMode
                animationView.contentMode = .scaleAspectFill
                animationView.center = self.view().center
                
                isReady = true
            }
            catch {
                isReady = false
            }
        }
    }
    
    
    // ------------------
    // Playback functions
    // ------------------
    private func play() {
        if (isReady && !animationView.isAnimationPlaying) {
            animationView.play()
        }
    }
    
    private func playFrom(fromProgress: CGFloat, toProgress: CGFloat, loopMode: [CGFloat]) {
        if (isReady && !animationView.isAnimationPlaying) {
            let lottieLoopMode = toLottieLoopMode(loopMode: loopMode);
            animationView.currentProgress = fromProgress;
            
            animationView.play(fromProgress: fromProgress, toProgress: toProgress, loopMode: lottieLoopMode, completion: { (Bool) -> Void in })
        }
    }
    
    private func pause() {
        if (isReady && animationView.isAnimationPlaying) {
            animationView.pause()
        }
    }
    
    private func reverse() {
        if (isReady) {
            animationView.play(fromProgress: 1, toProgress: 0, loopMode: .playOnce, completion: nil)
        }
    }
    
    private func stop() {
        if (isReady) {
            animationView.stop()
        }
    }
    
    private func setAnimationSpeed(speed: CGFloat) {
        if (isReady) {
            animationView.animationSpeed = speed;
        }
    }
    
    private func getAnimationSpeed() -> CGFloat {
        if (isReady) {
            return animationView.animationSpeed;
        }
        else {
            return 0.0
        }
    }
    
    // Convert [Float] to LottieLoopMode
    private func toLottieLoopMode(loopMode: [CGFloat]) -> LottieLoopMode {
        switch (loopMode[0]) {
            case 0:
                return .autoReverse
            case 1:
                return .loop
            case 2:
                return .playOnce
            case 3:
                return .repeat(Float(loopMode[1]))
            case 4:
                return .repeatBackwards(Float(loopMode[1]))
            default:
                return .playOnce
        }
    }
}
