import 'package:flutter/foundation.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class CurrentVideoProvider {
  final BehaviorSubject<VideoDto?> _currentVideoSink =
      BehaviorSubject<VideoDto?>.seeded(null);

  Stream<VideoDto?> get currentVideo$ => _currentVideoSink.stream;

  // ignore: avoid_void_async
  void setVideo(VideoDto video) async {
    if (!kIsWeb) {
      _currentVideoSink.add(video);
    } else {
      launch(video.url);
    }
  }

  /// method to stop and close VideoPlayer
  // ignore: avoid_void_async
  void close() async => _currentVideoSink.add(null);
}
