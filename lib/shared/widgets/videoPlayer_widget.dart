import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';

const double VIDEO_ASPECT_RATIO = 16 / 9;

/// Class that creates a video player depending on video URL and the description of the video
class VideoPlayer extends StatefulWidget {
  // final Color color;
  final VideoDto video;
  final bool isLoop;
  final BetterPlayerDataSource betterPlayerDataSource;

  VideoPlayer({
    Key? key,

    /// videoDTO
    required this.video,

    /// video data source
    BetterPlayerDataSource? betterPlayerDataSource,

    /// by default video does not loop
    this.isLoop = false,
  })  : this.betterPlayerDataSource =
            betterPlayerDataSource ?? BetterPlayerDataSource.network(video.url),
        super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  bool showVideo = false;

  /// contains the configuration for the display
  late BetterPlayerConfiguration betterPlayerConfiguration;

  /// contains the controller of the video
  late BetterPlayerController betterPlayerController;

  @override
  void initState() {
    /// establish configuration
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      aspectRatio: VIDEO_ASPECT_RATIO,
      fit: BoxFit.contain,
      autoPlay: false,
      autoDispose: true,
      allowedScreenSleep: false,
      looping: this.widget.isLoop,
      placeholder:
          Center(child: Image(image: this.widget.video.placeholderImage)),
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
      ],
    );
    betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    betterPlayerController.setupDataSource(this.widget.betterPlayerDataSource);
    super.initState();
  }

  @override
  void dispose() {
    betterPlayerController.pause();
    betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: VIDEO_ASPECT_RATIO,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BetterPlayer(controller: betterPlayerController),
      ),
    );
  }
}
