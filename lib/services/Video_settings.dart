import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/themes/colors.dart';
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
  bool showVideo = false;
  @override
  void initState() {
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
    return new ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: ColorsApp.red,
          child: (showVideo)
              ? Chewie(controller: chewieController)
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      showVideo = true;
                      chewieController = ChewieController(
                        videoPlayerController:
                            this.widget.videoPlayerController,
                        placeholder: Center(
                          child: Image(
                            image: AssetImage(
                                'assets/backgrounds/logo_background2.png'),
                          ),
                        ),
                        looping: this.widget.isLoop,
                        autoInitialize: true,
                        aspectRatio: 16 / 9,
                        allowedScreenSleep: false,
                        deviceOrientationsAfterFullScreen: [
                          DeviceOrientation.portraitUp
                        ],
                        materialProgressColors: ChewieProgressColors(
                          playedColor: this.widget.color,
                          handleColor: this.widget.color,
                        ),
                      );
                    });
                  },
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/backgrounds/logo_background2.png',
                        ),
                      ),
                      Center(
                          child: Icon(
                        Icons.play_arrow_rounded,
                        size: 80,
                        color: this.widget.color.withOpacity(0.5),
                      ))
                    ],
                  ),
                ),
        ),
      ),
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
    return new VideoPlayer(
      isLoop: false,
      videoPlayerController:
          VideoPlayerController.network(this.widget.videoUrl),
      color: this.widget.color,
    );
  }
}
