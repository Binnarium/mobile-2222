import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:video_player/video_player.dart';

class BackgroundVideo extends StatefulWidget {
  const BackgroundVideo({
    Key? key,
    required this.controller,
    this.lopping = true,
    this.onComplete,
    this.onPress,
  }) : super(key: key);

  final VideoPlayerController controller;

  final bool lopping;

  /// callback function when video stops
  final Function? onComplete;

  /// callback function when video stops
  final Function? onPress;

  @override
  _BackgroundVideoState createState() => _BackgroundVideoState();
}

class _BackgroundVideoState extends State<BackgroundVideo> {
  @override
  void initState() {
    super.initState();

    widget.controller.initialize().then((_) async {
      /// add event listeners
      if (widget.onComplete != null) {
        widget.controller.addListener(_videoCompletedListener);
      }

      /// set looping if enabled
      if (widget.lopping) {
        await widget.controller.setLooping(true);
      }

      /// set volume to 0 in case the video has volume
      await widget.controller.setVolume(0);
      await widget.controller.play();
      setState(() {});
    });
  }

  @override
  void activate() {
    super.activate();
    widget.controller.play();
  }

  @override
  void deactivate() {
    widget.controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_videoCompletedListener);
    widget.controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: widget.controller,
      builder: (context, VideoPlayerValue playerValue, _) {
        return Stack(
          children: [
            /// video background
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: playerValue.size.width,
                  height: playerValue.size.height,
                  child: AnimatedOpacity(
                      opacity: playerValue.isInitialized ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: VideoPlayer(widget.controller)),
                ),
              ),
            ),

            /// buffering video
            if (playerValue.isBuffering || !playerValue.isInitialized)
              Positioned(
                bottom: size.width * 0.04,
                left: size.width * 0.04,
                child: const CircularProgressIndicator(
                  backgroundColor: Colors2222.transparent,
                  color: Colors2222.white,
                ),
              ),

            /// decorator to make video tap enabled
            if (widget.onPress != null)
              Positioned(
                bottom: size.width * 0.04,
                right: size.width * 0.04,
                child: const Icon(
                  Icons.touch_app_rounded,
                  size: 36,
                ),
              ),

            /// material to capture on press events
            ///
            /// cover only available when a [onPress] method is provided
            if (widget.onPress != null)
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    // splashColor: city.color.withOpacity(0.5),
                    onTap: () => widget.onPress!(),
                    child: Container(),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  /// listener to run callback when the video completed
  /// add completed callback
  void _videoCompletedListener() {
    if (mounted &&
        widget.controller.value.isInitialized &&
        (widget.controller.value.duration ==
            widget.controller.value.position)) {
      widget.onComplete!();
    }
  }
}
