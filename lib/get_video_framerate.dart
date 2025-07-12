
import 'get_video_framerate_platform_interface.dart';

class GetVideoFramerate {
  Future<String?> getPlatformVersion() {
    return GetVideoFrameratePlatform.instance.getPlatformVersion();
  }
  Future<double?> getFPS(String url) {
    return GetVideoFrameratePlatform.instance.getFPS(url);
  }
}
