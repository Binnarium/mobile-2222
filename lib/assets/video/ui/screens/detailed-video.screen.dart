
import 'dart:async';
import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/video/models/video.model.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/services/connectivity-check.service.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class DetailedVideoScreen extends StatelessWidget {
  /// constructor
  DetailedVideoScreen({
    Key? key,
    required this.video,
  })  : controller = VideoPlayerController.network(video.url),
        super(key: key);

  /// params
  static const String route = '/detailed-video';

  final VideoModel video;

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold2222.empty(
      backgroundColor: Colors2222.black,
      body: SizedBox.expand(
        child: Lab2222VideoPlayer(controller: controller, videoDto: video),
      ),
    );
  }
}

class Lab2222VideoPlayer extends StatefulWidget {
  const Lab2222VideoPlayer({
    Key? key,
    required this.controller,
    required this.videoDto,
  }) : super(key: key);

  final VideoPlayerController controller;
  final VideoModel videoDto;

  @override
  State<Lab2222VideoPlayer> createState() => _Lab2222VideoPlayerState();
}

class _Lab2222VideoPlayerState extends State<Lab2222VideoPlayer> {
  bool showControls = true;

  Timer? currentTimer;

  /// provider of the connectivity check service
  late final ConnectivityCheckService conectivityProvider;

  @override
  void didChangeDependencies() {
    /// initialize the provider (needs to be on this method)
    conectivityProvider = Provider.of<ConnectivityCheckService>(context);
    conectivityProvider.checkConnectionType$(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    /// to avoid the screen to sleep
    Wakelock.enable();

    /// update interface with updated data
    widget.controller.addListener(() {
      if (mounted) setState(() {});
    });

    /// initialize video auto play
    widget.controller.initialize().then((_) {
      widget.controller.play();
      _startTimerHideControls();
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();

    /// to allow the screen to sleep
    Wakelock.disable();
    super.dispose();
  }

  @override
  void deactivate() {
    widget.controller.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: _startTimerHideControls,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          /// video
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: widget.controller.value.size.width,
                height: widget.controller.value.size.height,
                child: AnimatedOpacity(
                  opacity: widget.controller.value.isInitialized ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: VideoPlayer(widget.controller),
                ),
              ),
            ),
          ),

          /// loading indicator
          ///
          /// overlay of a spinner progress displayed only when a video is
          /// buffering or is not being initialized yet
          if (widget.controller.value.isBuffering ||
              !widget.controller.value.isInitialized)
            const Positioned.fill(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors2222.white,
                ),
              ),
            ),

          /// controls
          ///
          /// overlay with controls and actions
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: showControls ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: Stack(
                children: [
                  /// leading actions
                  Positioned(
                    left: size.width * 0.02,
                    top: size.width * 0.02,
                    child: Material(
                      color: Colors2222.darkGrey.withOpacity(0.8),
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(4),
                      child: IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),

                  /// trailing actions
                  Positioned(
                    right: size.width * 0.02,
                    top: size.width * 0.02,
                    child: Material(
                      color: Colors2222.darkGrey.withOpacity(0.8),
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(4),
                      child: IconButton(
                        icon: const Icon(Icons.warning_amber_rounded),
                        onPressed: _handleBottomSheet,
                      ),
                    ),
                  ),

                  /// bottom controls
                  Positioned(
                    left: size.width * 0.02,
                    right: size.width * 0.02,
                    bottom: size.width * 0.03,
                    child: VideoPlayerControls(controller: widget.controller),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startTimerHideControls() {
    setState(() {
      showControls = true;
      currentTimer?.cancel();
    });
    currentTimer = Timer(const Duration(seconds: 3), () {
      if (mounted)
        setState(() {
          showControls = false;
        });
    });
  }

  /// handle bottom drawer
  void _handleBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        bottom: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('El video no se carga, o carga demasiado lento'),
              onTap: () async {
                final HttpsCallable callable =
                    FirebaseFunctions.instance.httpsCallable('reportVideo');
                try {
                  await callable.call<dynamic>([
                    {
                      'problem': 'Video not loading',
                      'payload': widget.videoDto.toMap()
                    }
                  ]);
                } catch (e) {}
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Gracias por reportar tu problema. Pronto lo resolveremos',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('El video se queda en negro'),
              onTap: () async {
                final HttpsCallable callable =
                    FirebaseFunctions.instance.httpsCallable('reportVideo');
                try {
                  await callable.call<dynamic>([
                    {
                      'problem': 'Video is black screen',
                      'payload': widget.videoDto.toMap()
                    }
                  ]);
                } catch (e) {}
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Gracias por reportar tu problema. Pronto lo resolveremos',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerControls extends StatefulWidget {
  const VideoPlayerControls({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final VideoPlayerController controller;

  @override
  State<VideoPlayerControls> createState() => _VideoPlayerControlsState();
}

class _VideoPlayerControlsState extends State<VideoPlayerControls> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double space = size.width * 0.02;

    return Container(
      padding: EdgeInsets.all(space),
      decoration: BoxDecoration(
        color: Colors2222.darkGrey.withOpacity(0.8),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          VideoPlayerSlider(
            controller: widget.controller,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// rewind 5 seconds button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Material(
                  color: Colors2222.transparent,
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(4),
                  child: IconButton(
                    onPressed: () async {
                      final currentPos = await widget.controller.position;
                      final Duration newDuration = Duration(
                          seconds: max(0, (currentPos?.inSeconds ?? 0) - 5));
                      widget.controller.seekTo(newDuration);
                    },
                    icon: const Icon(Icons.replay_5_rounded),
                  ),
                ),
              ),

              /// play button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Material(
                  color: Colors2222.transparent,
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(4),
                  child: IconButton(
                    onPressed: () {
                      if (widget.controller.value.isPlaying)
                        widget.controller.pause();
                      else
                        widget.controller.play();
                    },
                    iconSize: 28,
                    icon: Icon(
                      widget.controller.value.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                    ),
                  ),
                ),
              ),

              /// forward 5 seconds button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Material(
                  color: Colors2222.transparent,
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(4),
                  child: IconButton(
                    onPressed: () async {
                      final currentPos = await widget.controller.position;
                      final Duration newDuration = Duration(
                          seconds: min(
                              widget.controller.value.duration.inSeconds,
                              (currentPos?.inSeconds ?? 0) + 5));
                      widget.controller.seekTo(newDuration);
                    },
                    icon: const Icon(Icons.forward_5_rounded),
                  ),
                ),
              ),

              /// video speed button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Material(
                  color: Colors2222.transparent,
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(4),
                  child: IconButton(
                    onPressed: _velocityBottomSheet,
                    icon: const Icon(Icons.speed_rounded),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// handle bottom drawer
  void _velocityBottomSheet() {
    final double currentSpeed = widget.controller.value.playbackSpeed;
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        bottom: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('Velocidad de reproducción'),
            ),
            ListTile(
              title: const Text('0.75'),
              minLeadingWidth: 20,
              leading: (currentSpeed == 0.75)
                  ? const Icon(
                      Icons.check_rounded,
                      size: 20,
                    )
                  : const SizedBox(),
              onTap: () async {
                widget.controller.setPlaybackSpeed(0.75);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('1.0'),
              minLeadingWidth: 20,
              leading: (currentSpeed == 1)
                  ? const Icon(
                      Icons.check_rounded,
                      size: 20,
                    )
                  : Container(width: 1),
              onTap: () async {
                widget.controller.setPlaybackSpeed(1.0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('1.25'),
              minLeadingWidth: 20,
              leading: (currentSpeed == 1.25)
                  ? const Icon(
                      Icons.check_rounded,
                      size: 20,
                    )
                  : Container(width: 1),
              onTap: () async {
                widget.controller.setPlaybackSpeed(1.25);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('1.5'),
              minLeadingWidth: 20,
              leading: (currentSpeed == 1.5)
                  ? const Icon(
                      Icons.check_rounded,
                      size: 20,
                    )
                  : Container(width: 1),
              onTap: () async {
                widget.controller.setPlaybackSpeed(1.5);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('2.0'),
              minLeadingWidth: 20,
              leading: (currentSpeed == 2.0)
                  ? const Icon(
                      Icons.check_rounded,
                      size: 20,
                    )
                  : Container(width: 1),
              onTap: () async {
                widget.controller.setPlaybackSpeed(2.0);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerSlider extends StatelessWidget {
  const VideoPlayerSlider({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            controller.value.position.toString().split('.')[0],
            style: textTheme.bodyText2,
            textAlign: TextAlign.right,
          ),
        ),

        ///
        Container(
          width: min(600, size.width * 0.5),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SliderTheme(
            data: SliderThemeData(
              trackShape: _CustomTrackShape(),
            ),
            child: Slider(
              activeColor: Colors2222.white,
              inactiveColor: Colors2222.white.withOpacity(0.5),
              min: 0.0,
              max: controller.value.duration.inSeconds.toDouble(),
              value: min(controller.value.duration.inSeconds.toDouble(),
                  controller.value.position.inSeconds.toDouble()),
              onChanged: (value) {
                controller.seekTo(Duration(seconds: value.toInt()));
              },
            ),
          ),
        ),

        ///
        Expanded(
          child: Text(
            controller.value.duration.toString().split('.')[0],
            style: textTheme.bodyText2,
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}

class _CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
