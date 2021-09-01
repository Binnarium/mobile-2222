import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/providers/videoPlayer_provider.dart';
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
  bool showVideo = false;
  VideoPlayerProvider? _videoPlayerProviderInstance;
  VideoPlayerProvider get videoProvider {
    if (this._videoPlayerProviderInstance == null) {
      this._videoPlayerProviderInstance =
          Provider.of<VideoPlayerProvider>(context, listen: false);
    }
    return this._videoPlayerProviderInstance!;
  }

  @override
  void initState() {
    super.initState();
    // videoProvider.setVideo(this.widget.video);
  }

  @override
  void dispose() {
    videoProvider.close();
    showVideo = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: VideoPlayerProvider.VIDEO_ASPECT_RATIO,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
            onTap: () {
              setState(() {
                videoProvider.setVideo(this.widget.video);
                showVideo = true;
              });
            },
            child: (showVideo)
                ? new BetterPlayer(
                    controller: videoProvider.betterPlayerController)
                : Stack(
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
                  )),
      ),
    );
  }
}
