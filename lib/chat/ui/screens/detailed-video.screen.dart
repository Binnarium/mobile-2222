import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:video_player/video_player.dart';

class DetailedVideoScreen extends StatelessWidget {
  /// constructor
  DetailedVideoScreen({
    Key? key,
    required this.video,
  })  : controller = VideoPlayerController.network(video.url),
        super(key: key);

  /// params
  static const String route = '/detailed-video';

  final VideoDto video;

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold2222.empty(
      // backgroundColor: Colors2222.darkGrey,
      backgroundColor: Colors2222.black,
      body: SizedBox.expand(
        child: Lab2222VideoPlayer(controller: controller),
      ),
    );
  }
}

class Lab2222VideoPlayer extends StatefulWidget {
  const Lab2222VideoPlayer({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final VideoPlayerController controller;

  @override
  State<Lab2222VideoPlayer> createState() => _Lab2222VideoPlayerState();
}

class _Lab2222VideoPlayerState extends State<Lab2222VideoPlayer> {
  bool showControls = true;

  Timer? currentTimer;

  @override
  void initState() {
    super.initState();

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

    return Stack(
      children: [
        /// video
        SizedBox.expand(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _startTimerHideControls(),
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
        ),

        /// loading indicator
        if (widget.controller.value.isBuffering ||
            !widget.controller.value.isInitialized)
          const Positioned.fill(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors2222.white,
              ),
            ),
          ),

        Positioned.fill(
          child: AnimatedOpacity(
            opacity: showControls ? 1 : 0,
            duration: const Duration(milliseconds: 500),
            child: Stack(
              children: [
                /// close button
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

                /// controls
                VideoPlayerControls(controller: widget.controller),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _startTimerHideControls() {
    showControls = true;
    currentTimer?.cancel();
    currentTimer = null;
    currentTimer = Timer(const Duration(seconds: 5), () {
      if (mounted)
        setState(() {
          showControls = false;
        });
    });
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

    return Positioned(
      left: space,
      right: space,
      bottom: space,
      child: Container(
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
                /// rewind 5 min button

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

                /// rewind 5 min button
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
              ],
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
              value: controller.value.position.inSeconds.toDouble(),
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