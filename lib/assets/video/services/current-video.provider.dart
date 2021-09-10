import 'package:flutter/foundation.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class CurrentVideoProvider {
  // TODO: remove comment
  // ignore: close_sinks
  final BehaviorSubject<VideoDto?> _currentVideoSink =
      BehaviorSubject<VideoDto?>.seeded(null);

  Stream<VideoDto?> get currentVideo$ => this._currentVideoSink.stream;

  void setVideo(VideoDto video) async {
    if (!kIsWeb) {
      this._currentVideoSink.add(video);
    } else {
      launch(video.url);
    }
  }

  /// method to stop and close VideoPlayer
  void close() async {
    this._currentVideoSink.add(null);
  }
}
