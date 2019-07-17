import Flutter
import UIKit
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
    let animationView: LOTAnimationView
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
        animationView = LOTAnimationView(frame: frame)
        
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
                    args!["isLoop"] as! Bool,
                    args!["autoReverse"] as! Bool
                )
                result(self!.isReady)
                break;
            case "play":
                self!.play()
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
            default:
                result(FlutterMethodNotImplemented)
            }
        })
    }
    
    public func view() -> UIView {
        return animationView;
    }
    
    
    //* FlotterAnimationView functions *//
    
    private func initialize(
        _ animationData: String,
        _ isLoop: Bool,
        _ autoReverse: Bool
    ) {
        if (!isReady) {
            let jsonObject: Any
            
            // Try convert json string to json object
            do {
                jsonObject = try JSONSerialization.jsonObject(with: animationData.data(using: .utf8)!, options : .allowFragments) as! [String:Any]
                
                // Set animationView
                animationView.setAnimation(json: jsonObject as! [AnyHashable : Any])
                animationView.loopAnimation = isLoop
                animationView.autoReverseAnimation = autoReverse
                animationView.contentMode = .scaleAspectFill
                animationView.center = self.view().center
                
                isReady = true
            }
            catch {
                isReady = false
            }
        }
    }
    
    private func play() {
        if (isReady && !animationView.isAnimationPlaying) {
            animationView.animationSpeed = 1
            animationView.play()
        }
    }
    
    private func pause() {
        if (isReady && animationView.isAnimationPlaying) {
            animationView.pause()
        }
    }
    
    private func reverse() {
        if (isReady) {
            animationView.animationSpeed = -1
            animationView.play()
        }
    }
    
    private func stop() {
        if (isReady) {
            animationView.stop()
        }
    }
}
