import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get_video_framerate/get_video_framerate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _videoFrameRate = -1.0;
  final _getVideoFrameratePlugin = GetVideoFramerate();

  @override
  void initState() {
    super.initState();
    initPluginExample();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPluginExample() async {
    double videoFrameRate;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      videoFrameRate =
          await _getVideoFrameratePlugin.getFPS("https://download.blender.org/peach/bigbuckbunny_movies/BigBuckBunny_320x180.mp4") ?? -1.0;
    } on PlatformException {
      videoFrameRate = -1.0;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _videoFrameRate = videoFrameRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Framerate: $_videoFrameRate\n'),
        ),
      ),
    );
  }
}
