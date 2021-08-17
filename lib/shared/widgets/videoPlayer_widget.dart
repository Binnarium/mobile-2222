import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:video_player/video_player.dart';

const double VideoAspectRatio = 16 / 9;

/// Class that creates a video player depending on video URL and the description of the video
class VideoPlayer extends StatefulWidget {
  final Color color;
  final VideoDto video;
  final bool isLoop;
  final VideoPlayerController controller;

  VideoPlayer({
    Key? key,
    required this.video,

    /// color used to match controls
    this.color = Colors2222.primary,
    VideoPlayerController? videoPlayerController,

    /// by default video does not loop
    this.isLoop = false,
  })  : this.controller =
            videoPlayerController ?? VideoPlayerController.network(video.url),
        super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  bool showVideo = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: VideoAspectRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: this.widget.color,
          child: (showVideo)

              /// video with controls
              ? _Video2222(
                  controller: this.widget.controller,
                  isLoop: this.widget.isLoop,
                  color: this.widget.color,
                )

              /// play video button
              /// when tapped show the video player
              : GestureDetector(
                  onTap: () => setState(() => showVideo = true),
                  child: _VideoPlaceholder(
                    color: this.widget.color,
                  ),
                ),
        ),
      ),
    );
  }
}

class _VideoPlaceholder extends StatelessWidget {
  _VideoPlaceholder({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    final HSLColor hslColor = HSLColor.fromColor(this.color);
    final Color darkenColor =
        hslColor.withLightness(hslColor.lightness - 0.1).toColor();

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: darkenColor,
          ),
        ),
        // background image
        // Image.asset(
        //   'assets/backgrounds/logo_background2.png',
        // ),
        Center(
          child: Icon(
            Icons.play_arrow_rounded,
            size: 80,
            color: Colors2222.white,
          ),
        )
      ],
    );
  }
}

/// intermediate player to load video on chewie
class _Video2222 extends Chewie {
  _Video2222({
    Key? key,
    required VideoPlayerController controller,
    required bool isLoop,
    required Color color,
  }) : super(
          key: key,
          controller: ChewieController(
            videoPlayerController: controller,
            looping: isLoop,
            placeholder: _VideoPlaceholder(color: color),
            autoInitialize: true,
            aspectRatio: VideoAspectRatio,
            allowedScreenSleep: false,

            /// allowed orientations
            deviceOrientationsAfterFullScreen: [
              DeviceOrientation.portraitUp,
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight
            ],

            /// bg color
            materialProgressColors: ChewieProgressColors(
              playedColor: color,
              handleColor: color,
              backgroundColor: Colors2222.white.withOpacity(0.2),
              bufferedColor: Colors2222.white.withOpacity(0.5),
            ),
          ),
        );
}
