import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_video_framerate/get_video_framerate_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelGetVideoFramerate platform = MethodChannelGetVideoFramerate();
  const MethodChannel channel = MethodChannel('get_video_framerate');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
