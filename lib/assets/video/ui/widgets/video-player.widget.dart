import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/assets/video/services/current-video.provider.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:provider/provider.dart';

/// Class that creates a video player depending on video URL and the description
/// of the video
class VideoPlayer extends StatefulWidget {
  const VideoPlayer({
    Key? key,

    /// videoDTO
    required this.video,
  }) : super(key: key);

  final VideoDto video;

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  // StreamSubscription? _currentPlayerSub;

  // CurrentVideoProvider get videoProvider =>
  //     Provider.of<CurrentVideoProvider>(context, listen: false);

  bool showPlayer = false;

  // @override
  // void initState() {
  //   videoProvider.close();
  //   super.initState();
  //   _currentPlayerSub = videoProvider.currentVideo$.listen(
  //     (currentVideo) {
  //       if (mounted) {
  //         setState(() {
  //           showPlayer = currentVideo?.path == widget.video.path;
  //         });
  //       }
  //     },
  //   );
  // }

  // @override
  // void dispose() {
  //   _currentPlayerSub?.cancel();
  //   videoProvider.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      // aspectRatio: CurrentVideoProvider.VIDEO_ASPECT_RATIO,
      aspectRatio: 16 / 9,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: _Lab2222BetterPlayer(video: widget.video)
          // : Stack(
          //     children: [
          //       Image(
          //         image: widget.video.placeholderImage,
          //         fit: BoxFit.cover,
          //         width: double.infinity,
          //         height: double.infinity,
          //       ),
          //       const Center(
          //         child: Icon(
          //           Icons.play_arrow_rounded,
          //           size: 150,
          //           color: Colors.black54,
          //         ),
          //       ),

          //       /// button action
          //       Positioned.fill(
          //         child: Material(
          //           color: Colors2222.transparent,
          //           child: InkWell(
          //             onTap: () =>show,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          ),
    );
  }
}

class _Lab2222BetterPlayer extends BetterPlayer {
  _Lab2222BetterPlayer({
    Key? key,
    required VideoDto video,
  }) : super(
          key: key,
          controller: BetterPlayerController(
            const BetterPlayerConfiguration(
              aspectRatio: 16 / 9,
              fit: BoxFit.contain,
              autoPlay: false,
              allowedScreenSleep: false,
              looping: false,
              // placeholder: Center(
              //   child: Image.asset('assets/images/video-placeholder.png'),
              // ),
              deviceOrientationsAfterFullScreen: [
                DeviceOrientation.portraitUp,
              ],
            ),
            betterPlayerDataSource: BetterPlayerDataSource.network(video.url),
          )..play(),
        );
}
