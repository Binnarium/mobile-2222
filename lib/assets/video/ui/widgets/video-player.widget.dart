import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/video/models/better-video.model.dart';
import 'package:lab_movil_2222/assets/video/models/video.model.dart';
import 'package:lab_movil_2222/assets/video/services/load-better-video.service.dart';
import 'package:lab_movil_2222/assets/video/ui/screens/detailed-video.screen.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

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
      if (mounted)
        setState(() {
          betterVideo = event;
        });
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
        child: Stack(
          children: [
            Image.asset(
              'assets/images/video-placeholder.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            if (betterVideo?.previewUrl != null)
              _VideoPreview(
                preview: NetworkImage(betterVideo!.previewUrl!),
                numberOfSprites: 10,
              ),

            /// button action
            if (betterVideo != null)
              Positioned.fill(
                child: Material(
                  color: Colors2222.transparent,
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      DetailedVideoScreen.route,
                      arguments: DetailedVideoScreen(video: betterVideo!),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.play_arrow_rounded,
                        size: 150,
                        color: Colors.black54,
                      ),
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

class _VideoPreview extends StatefulWidget {
  const _VideoPreview({
    Key? key,
    this.preview,
    required this.numberOfSprites,
  }) : super(key: key);

  final ImageProvider? preview;
  final int numberOfSprites;

  @override
  __VideoPreviewState createState() => __VideoPreviewState();
}

class __VideoPreviewState extends State<_VideoPreview> {
  /// current sprite counter
  int move = 1;

  /// internal timer to change sprites
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted)
        setState(() {
          move = (move + 1) % widget.numberOfSprites;
        });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: MemoryImage(kTransparentImage),
      image: widget.preview ?? MemoryImage(kTransparentImage),
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment(
        map(move.toDouble(), 0, widget.numberOfSprites - 1, -1, 1, true),
        0,
      ),
    );
  }

  /// TODO: move to correct file
  double map(double n, double start1, double stop1, double start2, double stop2,
      bool withinBounds) {
    final newval = (n - start1) / (stop1 - start1) * (stop2 - start2) + start2;
    if (!withinBounds) {
      return newval;
    }
    if (start2 < stop2) {
      return constrain(newval, start2, stop2);
    } else {
      return constrain(newval, stop2, start2);
    }
  }

  /// TODO: move to correct file
  double constrain(double n, double low, double high) {
    return max(min(n, high), low);
  }
}
