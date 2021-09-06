import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/assets/video/services/current-video.provider.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:provider/provider.dart';

/// Class that creates a video player depending on video URL and the description of the video
class VideoPlayer extends StatefulWidget {
  final VideoDto video;

  VideoPlayer({
    Key? key,

    /// videoDTO
    required this.video,
  }) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  StreamSubscription? _currentPlayerSub;

  CurrentVideoProvider get videoProvider =>
      Provider.of<CurrentVideoProvider>(context, listen: false);

  bool showPlayer = false;

  @override
  void initState() {
    this.videoProvider.close();
    super.initState();
    this._currentPlayerSub = this.videoProvider.currentVideo$.listen(
      (currentVideo) {
        if (this.mounted)
          this.setState(() {
            this.showPlayer = currentVideo?.path == this.widget.video.path;
          });
      },
    );
  }

  @override
  void dispose() {
    this._currentPlayerSub?.cancel();
    this.videoProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      // aspectRatio: CurrentVideoProvider.VIDEO_ASPECT_RATIO,
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: this.showPlayer
            ? Lab2222BetterPlayer(video: this.widget.video)
            : InkWell(
                onTap: () => videoProvider.setVideo(this.widget.video),
                child: Stack(
                  children: [
                    Image(
                      image: this.widget.video.placeholderImage,
                    ),
                    Center(
                      child: Icon(
                        Icons.play_arrow_rounded,
                        size: 150,
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class Lab2222BetterPlayer extends BetterPlayer {
  Lab2222BetterPlayer({
    Key? key,
    required VideoDto video,
  }) : super(
          key: key,
          controller: BetterPlayerController(
            BetterPlayerConfiguration(
              aspectRatio: 16 / 9,
              fit: BoxFit.contain,
              autoPlay: false,
              allowedScreenSleep: false,
              looping: false,

              /// TODO: create specific widget
              placeholder: Center(
                child: Image.asset('assets/images/video-placeholder.png'),
              ),
              deviceOrientationsAfterFullScreen: [
                DeviceOrientation.portraitUp,
              ],
            ),
            betterPlayerDataSource: BetterPlayerDataSource.network(video.url),
          )..play(),
        );
}
