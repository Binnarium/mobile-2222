import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool isLoop;
  final Color color;

  const VideoPlayer({
    Key? key,
    required this.videoPlayerController,
    required this.isLoop,
    required this.color,
  }) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late ChewieController chewieController;

  @override
  void initState() {
    chewieController = ChewieController(
      videoPlayerController: this.widget.videoPlayerController,
      looping: this.widget.isLoop,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      allowedScreenSleep: false,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      placeholder: Container(
        color: Colors.black87,
        child: Container(
          child: Center(
              child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(this.widget.color),
          )),
        ),
      ),
      materialProgressColors: ChewieProgressColors(
        playedColor: this.widget.color,
        handleColor: this.widget.color,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    chewieController.dispose();
    this.widget.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(controller: chewieController),
    );
  }
}

class VideoDisplay extends StatefulWidget {
  final String videoUrl;
  final Color color;
  const VideoDisplay({Key? key, required this.videoUrl, required this.color})
      : super(key: key);

  @override
  _VideoDisplayState createState() => _VideoDisplayState();
}

class _VideoDisplayState extends State<VideoDisplay> {
  @override
  Widget build(BuildContext context) {
    return VideoPlayer(
      isLoop: false,
      videoPlayerController:
          VideoPlayerController.network(this.widget.videoUrl),
      color: this.widget.color,
    );
  }
}
