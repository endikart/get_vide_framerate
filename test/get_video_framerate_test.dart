import 'package:flutter_test/flutter_test.dart';
import 'package:get_video_framerate/get_video_framerate.dart';
import 'package:get_video_framerate/get_video_framerate_platform_interface.dart';
import 'package:get_video_framerate/get_video_framerate_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGetVideoFrameratePlatform
    with MockPlatformInterfaceMixin
    implements GetVideoFrameratePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
  
  @override
  Future<double?> getFPS(String url) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }
}

void main() {
  final GetVideoFrameratePlatform initialPlatform = GetVideoFrameratePlatform.instance;

  test('$MethodChannelGetVideoFramerate is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGetVideoFramerate>());
  });

  test('getPlatformVersion', () async {
    GetVideoFramerate getVideoFrameratePlugin = GetVideoFramerate();
    MockGetVideoFrameratePlatform fakePlatform = MockGetVideoFrameratePlatform();
    GetVideoFrameratePlatform.instance = fakePlatform;

    expect(await getVideoFrameratePlugin.getPlatformVersion(), '42');
  });
}
