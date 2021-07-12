import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';
import 'package:video_player/video_player.dart';

/// Class that creates a video player depending on video URL and the description of the video
class VideoPlayerSegment extends StatefulWidget {
  final String videoUrl;
  final Color color;
  final String? description;
  VideoPlayerSegment(
      {Key? key, required this.videoUrl, this.description, required this.color})
      : super(key: key);

  @override
  _VideoPlayerSegment createState() => _VideoPlayerSegment();
}

class _VideoPlayerSegment extends State<VideoPlayerSegment> {
  /// controller of the video
  late VideoPlayerController _controller;

  /// initialization of the videoplayer
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    /// initialization of the controller with the given url
    _controller = VideoPlayerController.network(this.widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    /// dispose of the controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _videoContent(size, this.widget.description, this.widget.videoUrl);
  }

  _videoContent(Size size, String? description, String url) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 30),
      child: Column(
        children: [
          _textContent(size, description),
          SizedBox(
            height: 50,
          ),

          /// calls the video player
          _videoContainer(size, url),
          SizedBox(height: 10),
          _videoButtons(_controller),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  _textContent(Size size, String? description) {
    return Text(
      (description == null) ? '' : description,
      style: korolevFont.bodyText1?.apply(),
    );
  }

  /// method that builds the video player, given the url
  _videoContainer(Size size, String url) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          /// If VideoPlayerController has ended initialization, uses the data
          /// provided to limit the aspect ratio of the videoplayer
          return AspectRatio(
            /// to control the maxHeight of the video
            // constraints: BoxConstraints(maxHeight: size.height * 0.35),
            aspectRatio: _controller.value.aspectRatio,

            /// the video player
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  _ControlsOverlay(controller: _controller),
                  VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    colors: VideoProgressColors(playedColor: Colors.white),
                  ),
                ],
              ),
            ),
          );
        } else {
          // Si el VideoPlayerController todavía se está inicializando, muestra un
          // spinner de carga
          return Center(
              child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
              Colors.white,
            ),
          ));
        }
      },
    );
  }

  _videoButtons(VideoPlayerController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildVideoButton(Icon(Icons.replay_5_rounded), _rewind5Seconds),
        _buildVideoButton(
            (_controller.value.isPlaying)
                ? Icon(Icons.pause_rounded)
                : Icon(Icons.play_arrow_rounded),
            _playOrPause),
        _buildVideoButton(Icon(Icons.forward_5_rounded), _forward5Seconds),
        // Expanded(child: Container()),
      ],
    );
  }

  Widget _buildVideoButton(Widget child, Function() onPressed) => Container(
        child: ElevatedButton(
          onPressed: onPressed,
          child: child,
          style: ElevatedButton.styleFrom(
            onPrimary: this.widget.color,
            primary: Colors.white,
            alignment: Alignment.center,
          ),
        ),
      );

  Future _rewind5Seconds() async => (_goToPosition(
      (currentPosition) => currentPosition - Duration(seconds: 5)));
  Future _forward5Seconds() async => (_goToPosition(
      (currentPosition) => currentPosition + Duration(seconds: 5)));

  Future _playOrPause() async {
    if (_controller.value.position == _controller.value.duration) {
      _controller.initialize();
      _controller.play();
      setState(() {});
    } else {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
      setState(() {});
    }
  }

  /// to change the icon
  Future<Icon> _playButtonIcon() async {
    if (_controller.value.position == _controller.value.duration) {
      _controller.initialize();
      _controller.play();
      setState(() {});
      return Icon(Icons.replay_rounded);
    } else {
      if (_controller.value.isPlaying) {
        _controller.pause();
        setState(() {});
        return Icon(Icons.pause_rounded);
      } else {
        _controller.play();
        setState(() {});
        return Icon(Icons.play_arrow_rounded);
      }
    }
  }

  Future _goToPosition(
    Duration Function(Duration currentPosition) builder,
  ) async {
    final currentPosition = await _controller.position;
    final newPosition = builder(currentPosition!);

    await _controller.seekTo(newPosition);
  }
}

class _ControlsOverlay extends StatefulWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  static const _examplePlaybackRates = [
    0.5,
    1.0,
    1.5,
    2.0,
  ];

  final VideoPlayerController controller;

  @override
  __ControlsOverlayState createState() => __ControlsOverlayState();
}

class __ControlsOverlayState extends State<_ControlsOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          reverseDuration: Duration(milliseconds: 400),
          switchInCurve: Curves.easeIn,
          child: widget.controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black38,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),

        /// to set the playback speed of the video
        // Align(
        //   alignment: Alignment.topRight,
        //   child: PopupMenuButton<double>(
        //     initialValue: widget.controller.value.playbackSpeed,
        //     tooltip: 'Playback speed',
        //     onSelected: (speed) {
        //       widget.controller.setPlaybackSpeed(speed);
        //       setState(() {});
        //     },
        //     itemBuilder: (context) {
        //       return [
        //         for (final speed in _ControlsOverlay._examplePlaybackRates)
        //           PopupMenuItem(
        //             value: speed,
        //             textStyle: TextStyle(color: Colors.black),
        //             child: Text('${speed}x'),
        //           )
        //       ];
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(
        //         // Using less vertical padding as the text is also longer
        //         // horizontally, so it feels like it would need more spacing
        //         // horizontally (matching the aspect ratio of the video).
        //         vertical: 12,
        //         horizontal: 16,
        //       ),
        //       child: Text('${widget.controller.value.playbackSpeed}x'),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
