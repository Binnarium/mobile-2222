import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';

class VideoPlayerProvider with ChangeNotifier {
  static const double VIDEO_ASPECT_RATIO = 16 / 9;

  VideoDto? _currentVideo;

  VideoDto? get currentVideo => this._currentVideo;
  BetterPlayerController _betterPlayerController =
      new BetterPlayerController(BetterPlayerConfiguration());

  BetterPlayerController get betterPlayerController =>
      this._betterPlayerController;

  VideoPlayerProvider() {
    /// establish configuration
    final BetterPlayerConfiguration _betterPlayerConfiguration =
        BetterPlayerConfiguration(
      aspectRatio: VIDEO_ASPECT_RATIO,
      fit: BoxFit.contain,
      autoPlay: false,
      autoDispose: true,
      allowedScreenSleep: false,
      looping: false,
      placeholder:
          Center(child: Image.asset('assets/images/video-placeholder.png')),
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
      ],
    );

    /// controller of the video
    _betterPlayerController =
        new BetterPlayerController(_betterPlayerConfiguration);
  }

  Future<void> setVideo(VideoDto video) async {
    this._currentVideo = video;
    try {
      await _betterPlayerController
          .setupDataSource(BetterPlayerDataSource.network(video.url))
          .then((_) async {
        await _betterPlayerController.play();
        notifyListeners();
      });
    } catch (e) {
      print("Error loading video source: $e");
    }
  }

  /// method to stop and close VideoPlayer
  close() {
    this._betterPlayerController.pause();
    this._betterPlayerController.videoPlayerController = null;
    this._currentVideo = null;
    this._betterPlayerController.videoPlayerController?.dispose();
    this._betterPlayerController.dispose();
    print('video disposed');
    notifyListeners();
  }
}
