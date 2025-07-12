//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<get_video_framerate/GetVideoFrameratePlugin.h>)
#import <get_video_framerate/GetVideoFrameratePlugin.h>
#else
@import get_video_framerate;
#endif

#if __has_include(<integration_test/IntegrationTestPlugin.h>)
#import <integration_test/IntegrationTestPlugin.h>
#else
@import integration_test;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [GetVideoFrameratePlugin registerWithRegistrar:[registry registrarForPlugin:@"GetVideoFrameratePlugin"]];
  [IntegrationTestPlugin registerWithRegistrar:[registry registrarForPlugin:@"IntegrationTestPlugin"]];
}

@end
