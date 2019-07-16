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
    let animationData: String
    let methodChannel: FlutterMethodChannel
    let animationView: LOTAnimationView
    
    init(_ frame: CGRect, viewId: Int64, args: Any?, binaryMessenger messenger: (NSObjectProtocol & FlutterBinaryMessenger)?) {
        self.frame = frame
        self.viewId = viewId
        
        // Parse args
        let arguments = args as? Dictionary<String, Any>
        
        if (arguments != nil) {
            animationId = arguments?["animationId"] as! String
            animationData = arguments?["animationData"] as! String
        }
        else {
            animationId = "nil"
            animationData = "nil"
        }
        
        // Initialize methodChannel and animationView
        methodChannel = FlutterMethodChannel(name: "flotter-\(animationId)", binaryMessenger: messenger!)
        animationView = LOTAnimationView(frame: frame)
        
        super.init()
        
        // Add handle call method
        methodChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            guard call.method == "start" else {
                result(FlutterMethodNotImplemented)
                return
            }
            result(true)
        })
    }
    
    public func view() -> UIView {
        return LOTAnimationView(frame: frame)
    }
}
