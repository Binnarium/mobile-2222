import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/video/models/better-video.model.dart';
import 'package:lab_movil_2222/assets/video/models/video.model.dart';
import 'package:lab_movil_2222/assets/video/services/load-better-video.service.dart';
import 'package:lab_movil_2222/assets/video/ui/screens/detailed-video.screen.dart';
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

  final VideoModel video;

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  BetterVideoModel? betterVideo;
  StreamSubscription? _loadBetterVideoSub;

  LoadBetterVideoService get loadBetterVideoService =>
      Provider.of<LoadBetterVideoService>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _loadBetterVideoSub =
        loadBetterVideoService.loadFromPath$(widget.video.path).listen((event) {
      betterVideo = event;
    });
  }

  @override
  void dispose() {
    _loadBetterVideoSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        // child: _Lab2222BetterPlayer(video: widget.video)
        child: Stack(
          children: [
            Image.asset(
              'assets/images/video-placeholder.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            const Center(
              child: Icon(
                Icons.play_arrow_rounded,
                size: 150,
                color: Colors.black54,
              ),
            ),

            /// button action
            Positioned.fill(
              child: Material(
                color: Colors2222.transparent,
                child: InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    DetailedVideoScreen.route,
                    arguments: DetailedVideoScreen(video: widget.video),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
