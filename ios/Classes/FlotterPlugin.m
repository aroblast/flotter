#import "FlotterPlugin.h"
#import <flotter/flotter-Swift.h>

@implementation FlotterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlotterPlugin registerWithRegistrar:registrar];
}
@end
