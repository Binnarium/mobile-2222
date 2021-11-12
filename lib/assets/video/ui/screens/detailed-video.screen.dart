import 'dart:async';
import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/video/models/better-video.model.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/services/connectivity-check.service.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class DetailedVideoScreen extends StatefulWidget {
  /// constructor
  const DetailedVideoScreen({
    Key? key,
    required this.video,
  }) : super(key: key);

  /// params
  static const String route = '/detailed-video';

  final BetterVideoModel video;

  @override
  State<DetailedVideoScreen> createState() => _DetailedVideoScreenState();
}

class _DetailedVideoScreenState extends State<DetailedVideoScreen> {
  /// provider of the connectivity check service
  late final ConnectivityCheckService connectivityProvider;
  late final VideoPlayerController controller;

  /// variable that will allow us to know the current connection type
  late final ConnectivityResult connectionStatus;

  @override
  void didChangeDependencies() {
    /// initialize the provider (needs to be on this method)
    connectivityProvider = Provider.of<ConnectivityCheckService>(context);
    connectivityProvider.checkConnectionType$();
    connectionStatus = connectivityProvider.connectionType;

    /// initializes the controller depending on user connection type
    if (connectionStatus == ConnectivityResult.wifi) {
      controller = VideoPlayerController.network(widget.video.hdUrl!);
    } else {
      controller = VideoPlayerController.network(widget.video.sdUrl!);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2222.empty(
      backgroundColor: Colors2222.black,
      body: SizedBox.expand(
        child: Lab2222VideoPlayer(controller: controller, video: widget.video),
      ),
    );
  }
}

class Lab2222VideoPlayer extends StatefulWidget {
  const Lab2222VideoPlayer({
    Key? key,
    required this.controller,
    required this.video,
  }) : super(key: key);

  final VideoPlayerController controller;
  final BetterVideoModel video;

  @override
  State<Lab2222VideoPlayer> createState() => _Lab2222VideoPlayerState();
}

class _Lab2222VideoPlayerState extends State<Lab2222VideoPlayer> {
  bool showControls = true;

  Timer? currentTimer;

  @override
  void initState() {
    super.initState();

    /// to avoid the screen to sleep
    Wakelock.enable();

    /// initialize video auto play
    widget.controller.initialize().then((_) {
      widget.controller.play();
      _startTimerHideControls();
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

    /// the video quality
    bool isHD = false;

    /// checks the link of the video depending on quality
    if (widget.video.sdUrl == widget.controller.dataSource) {
      isHD = false;
    }
    if (widget.video.hdUrl == widget.controller.dataSource) {
      isHD = true;
    }

    return Stack(
      children: [
        /// video
        ValueListenableBuilder<VideoPlayerValue>(
          valueListenable: widget.controller,
          child: VideoPlayer(widget.controller),
          builder: (context, state, child) {
            return SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: state.size.width,
                  height: state.size.height,
                  child: AnimatedOpacity(
                    opacity: state.isInitialized ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: child,
                  ),
                ),
              ),
            );
          },
        ),

        /// detect when user taps in screen
        Positioned.fill(
          child: GestureDetector(
            onTap: _startTimerHideControls,
            behavior: HitTestBehavior.opaque,
            child: const SizedBox.expand(),
          ),
        ),

        /// loading indicator
        ///
        /// overlay of a spinner progress displayed only when a video is
        /// buffering or is not being initialized yet
        ValueListenableBuilder<VideoPlayerValue>(
          valueListenable: widget.controller,
          child: const Positioned.fill(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors2222.white,
              ),
            ),
          ),
          builder: (context, state, child) {
            if (state.isBuffering || !state.isInitialized) return child!;
            return Container();
          },
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
                  child: VideoPlayerControls(
                      controller: widget.controller, isHD: isHD),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _startTimerHideControls() {
    setState(() {
      showControls = true;
      currentTimer?.cancel();
    });
    currentTimer = Timer(const Duration(seconds: 5), () {
      if (mounted)
        setState(() {
          showControls = false;
          currentTimer?.cancel();
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
              title:
                  const Text('El video no se carga, o carga demasiado lento'),
              onTap: () async {
                final HttpsCallable callable =
                    FirebaseFunctions.instance.httpsCallable('reportVideo');
                try {
                  await callable.call<dynamic>([
                    {
                      'problem': 'Video not loading',
                      'payload': widget.video.toMap()
                    }
                  ]);
                } catch (e) {
                  print(e);
                }
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Gracias por reportar tu problema. Pronto lo resolveremos',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('El video se queda en negro'),
              onTap: () async {
                final HttpsCallable callable =
                    FirebaseFunctions.instance.httpsCallable('reportVideo');
                try {
                  await callable.call<dynamic>([
                    {
                      'problem': 'Video is black screen',
                      'payload': widget.video.toMap()
                    }
                  ]);
                } catch (e) {
                  print(e);
                }
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
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
    this.isHD,
  }) : super(key: key);

  final VideoPlayerController controller;
  final bool? isHD;

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
              ValueListenableBuilder<VideoPlayerValue>(
                valueListenable: widget.controller,
                builder: (context, state, _) {
                  return Padding(
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
                          state.isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                        ),
                      ),
                    ),
                  );
                },
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Material(
                  color: Colors2222.transparent,
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(4),
                  child: IconButton(
                      onPressed: null,
                      icon: (widget.isHD!)
                          ? const Icon(Icons.hd_outlined)
                          : const Icon(Icons.sd_outlined)),
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
    final Map<Object, double> velocitiesMap = {
      0.5: 0.5,
      0.75: 0.75,
      1.0: 1,
      1.25: 1.25,
      1.5: 1.5,
      2: 2,
    };

    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        bottom: true,
        child: ListView(
          shrinkWrap: true,
          // mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Velocidad de reproducción',
                textAlign: TextAlign.center,
              ),
            ),
            for (var i = 0; i < velocitiesMap.length; i++) ...{
              ListTile(
                title: Text(velocitiesMap.values.elementAt(i).toString()),
                minLeadingWidth: 20,
                leading: currentSpeed == velocitiesMap.values.elementAt(i)
                    ? const Icon(Icons.check_rounded, size: 20)
                    : const SizedBox(),
                onTap: () async {
                  widget.controller
                      .setPlaybackSpeed(velocitiesMap.values.elementAt(i));
                  Navigator.pop(context);
                },
              ),
            },
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
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller,
      builder: (context, state, _) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                state.position.toString().split('.')[0],
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
                  max: state.duration.inSeconds.toDouble(),
                  value: min(state.duration.inSeconds.toDouble(),
                      state.position.inSeconds.toDouble()),
                  onChanged: (value) {
                    controller.seekTo(Duration(seconds: value.toInt()));
                  },
                ),
              ),
            ),

            ///
            Expanded(
              child: Text(
                state.duration.toString().split('.')[0],
                style: textTheme.bodyText2,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        );
      },
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
