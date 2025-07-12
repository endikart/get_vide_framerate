import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'get_video_framerate_platform_interface.dart';

/// An implementation of [GetVideoFrameratePlatform] that uses method channels.
class MethodChannelGetVideoFramerate extends GetVideoFrameratePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('get_video_framerate');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<double> getFPS(String url) async {
    final reply = await methodChannel.invokeMethod<double>(
      'getFPS',
      {'url': url},
    );
    return reply ?? -1.0;
  }
}
