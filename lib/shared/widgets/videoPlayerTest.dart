import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';

class VideoPlayerTest extends StatefulWidget {
  final VideoDto video;
  final bool isLoop;

  const VideoPlayerTest({
    Key? key,
    required this.video,
    this.isLoop = false,
  }) : super(key: key);

  @override
  _VideoPlayerTestState createState() => _VideoPlayerTestState();
}

class _VideoPlayerTestState extends State<VideoPlayerTest> {
  late BetterPlayerController betterPlayerController;
  late BetterPlayerDataSource betterPlayerDataSource;
  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      autoPlay: false,
      looping: false,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
      ],
    );
    betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      this.widget.video.url,
    );
    betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    betterPlayerController.setupDataSource(betterPlayerDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayer(
      controller: betterPlayerController,
    );
  }
}
