import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'get_video_framerate_method_channel.dart';

abstract class GetVideoFrameratePlatform extends PlatformInterface {
  /// Constructs a GetVideoFrameratePlatform.
  GetVideoFrameratePlatform() : super(token: _token);

  static final Object _token = Object();

  static GetVideoFrameratePlatform _instance = MethodChannelGetVideoFramerate();

  /// The default instance of [GetVideoFrameratePlatform] to use.
  ///
  /// Defaults to [MethodChannelGetVideoFramerate].
  static GetVideoFrameratePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GetVideoFrameratePlatform] when
  /// they register themselves.
  static set instance(GetVideoFrameratePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<double?> getFPS(String url) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
