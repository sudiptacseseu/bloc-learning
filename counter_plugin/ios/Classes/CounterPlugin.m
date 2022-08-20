#import "CounterPlugin.h"
#if __has_include(<counter_plugin/counter_plugin-Swift.h>)
#import <counter_plugin/counter_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "counter_plugin-Swift.h"
#endif

@implementation CounterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCounterPlugin registerWithRegistrar:registrar];
}
@end
