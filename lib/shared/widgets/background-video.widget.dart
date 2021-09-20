import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BackgroundVideo extends StatefulWidget {
  const BackgroundVideo({
    Key? key,
    required this.controller,
    this.lopping = true,
    this.onComplete,
    this.onPressed,
  }) : super(key: key);

  final VideoPlayerController controller;
  final bool lopping;

  /// callback function when video stops
  final Function? onComplete;

  /// callback function when video stops
  final Function? onPressed;

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
  void dispose() {
    widget.controller.removeListener(_videoCompletedListener);
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// video background
        SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: widget.controller.value.size.width,
              height: widget.controller.value.size.height,
              child: AnimatedOpacity(
                  opacity: widget.controller.value.isInitialized ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: VideoPlayer(widget.controller)),
            ),
          ),
        ),

        /// material to capture on press events
        ///
        /// cover only available when a [onPress] method is provided
        if (widget.onPressed != null)
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                // splashColor: city.color.withOpacity(0.5),
                onTap: () => widget.onPressed!(),
                child: Container(),
              ),
            ),
          ),
      ],
    );
  }

  /// listener to run callback when the video completed
  /// add completed callback
  void _videoCompletedListener() {
    if (widget.controller.value.isInitialized &&
        (widget.controller.value.duration ==
            widget.controller.value.position)) {
      widget.onComplete!();
    }
  }
}
