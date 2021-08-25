import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BackgroundVideo extends StatefulWidget {
  BackgroundVideo({
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
    final VideoPlayerController ctrl = this.widget.controller;

    ctrl.initialize().then((value) async {
      /// add event listeners
      if (this.widget.onComplete != null)
        ctrl.addListener(() {
          /// add completed callback
          if (ctrl.value.isInitialized &&
              (ctrl.value.duration == ctrl.value.position))
            this.widget.onComplete!();
        });

      /// set looping if enabled
      if (this.widget.lopping) await ctrl.setLooping(true);

      /// set volume to 0 in case the video has volume
      await ctrl.setVolume(0);
      await ctrl.play();
      this.setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    this.widget.controller.dispose();
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
              width: this.widget.controller.value.size.width,
              height: this.widget.controller.value.size.height,
              child: AnimatedOpacity(
                  opacity:
                      this.widget.controller.value.isInitialized ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: VideoPlayer(this.widget.controller)),
            ),
          ),
        ),

        /// material to capture on press events
        ///
        /// cover only available when a [onPress] method is provided
        if (this.widget.onPressed != null)
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                // splashColor: this.city.color.withOpacity(0.5),
                onTap: () => this.widget.onPressed!(),
                child: Container(),
              ),
            ),
          ),
      ],
    );
  }
}
