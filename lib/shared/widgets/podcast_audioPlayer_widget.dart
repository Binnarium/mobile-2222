import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/providers/audioPlayer_provider.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';
import 'package:provider/provider.dart';

class PodcastAudioPlayer extends StatefulWidget {
  final AudioDto audio;
  final Color color;

  PodcastAudioPlayer({
    Key? key,
    required this.audio,
    required this.color,
  }) : super(key: key);

  @override
  __PodcastAudioPlayerState createState() => __PodcastAudioPlayerState();
}

class __PodcastAudioPlayerState extends State<PodcastAudioPlayer> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  Icon _playIcon = Icon(Icons.play_arrow_rounded);

  AudioPlayerProvider? _audioProviderInstance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    // this.audioProvider.close();
    print("TODO: Audio provider disposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: move to correct file
    // _textContent(this.widget.description, size),
    // SizedBox(height: 30),
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        /// TODO: temp
        if (this.audioProvider.current?.path == this.widget.audio.path)
          Center(
            child: Text('Reproduciendo este audio'),
          ),

        /// progress indicator
        if (this.audioProvider.current?.path == this.widget.audio.path)
          // Future _goToPosition(
          //   Duration Function(Duration currentPosition) builder,
          // ) async {
          //   final currentPosition = audioPlayer.position;
          //   final newPosition = builder(currentPosition);

          //   await audioPlayer.seek(newPosition);
          // }
          Container(
            height: 20,
            padding: EdgeInsets.only(bottom: 4),
            child: _AudioSlider(
              duration$: this.audioProvider.duration$!,
              moveTo: (position) {},
              progress$: this.audioProvider.position$!,
            ),
          )
        else
          _FakeAudioSlider(),

        /// current time, and time remaining
        Container(
          padding: EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _position.toString().split(".")[0],
                style: korolevFont.bodyText2,
              ),
              Text(
                _duration.toString().split(".")[0],
                style: korolevFont.bodyText2,
              ),
            ],
          ),
        ),

        /// controls
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /// rewind button

            // _buildVideoButton(
            //     Icon(
            //       Icons.replay_5_rounded,
            //     ),
            //     _rewind5Seconds,
            //     size),

            /// play button
            // _buildVideoButton(_playIcon, _playOrPause, size),
            IconButton(
              onPressed: () {
                audioProvider.setAudio(this.widget.audio);
              },
              icon: Icon(Icons.play_arrow),
            )

            /// forward button
            // _buildVideoButton(
            //     Icon(Icons.forward_5_rounded), _forward5Seconds, size),
          ],
        )
      ],
    );
  }

  // _textContent(String? description, Size size) {
  //   return Container(
  //     // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
  //     // width: size.width * 0.5,
  //     child: (description == null)
  //         ? Text('No description Available')
  //         : Markdown2222(data: description),
  //   );
  // }

  // Widget _buildVideoButton(Widget child, Function() onPressed, Size size) =>
  //     Container(
  //       // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
  //       width: size.width * 0.1,
  //       height: size.height * 0.07,
  //       child: ElevatedButton(
  //         onPressed: onPressed,
  //         child: child,
  //         style: ElevatedButton.styleFrom(
  //           onPrimary: this.widget.color,
  //           primary: Colors.white,
  //           alignment: Alignment.center,
  //           padding: EdgeInsets.all(0),
  //           shape: CircleBorder(),
  //         ),
  //       ),
  //     );

  // Future _rewind5Seconds() async => (_goToPosition((currentPosition) {
  //       if (currentPosition - Duration(seconds: 5) <= Duration.zero) {
  //         return Duration.zero;
  //       }
  //       return currentPosition - Duration(seconds: 5);
  //     }));
  // Future _forward5Seconds() async => (_goToPosition((currentPosition) {
  //       if (currentPosition + Duration(seconds: 5) >= audioPlayer.duration!) {
  //         return audioPlayer.duration!;
  //       }
  //       return currentPosition + Duration(seconds: 5);
  //     }));

  // Future _playOrPause() async {
  //   if (audioPlayer.playing) {
  //     if (audioPlayer.position >= audioPlayer.duration!) {
  //       setState(() {
  //         audioPlayer.seek(Duration.zero);
  //         _playIcon = Icon(Icons.pause_rounded);
  //         audioPlayer.play();
  //       });
  //     } else {
  //       setState(() {
  //         _playIcon = Icon(Icons.play_arrow_rounded);
  //         audioPlayer.pause();
  //       });
  //     }
  //   } else {
  //     setState(() {
  //       _playIcon = Icon(Icons.pause_rounded);
  //       audioPlayer.play();
  //     });
  //   }
  // }

  // void _changeToSecond(int second) {
  //   Duration newDuration = Duration(seconds: second);
  //   audioPlayer.seek(newDuration);
  // }

  AudioPlayerProvider get audioProvider {
    if (this._audioProviderInstance == null)
      this._audioProviderInstance = Provider.of<AudioPlayerProvider>(context);
    return this._audioProviderInstance!;
  }
}

class _FakeAudioSlider extends _AudioSlider {
  _FakeAudioSlider()
      : super(
          progress$: Stream.empty(),
          duration$: Stream.value(Duration(seconds: 211)),
        );
}

class _AudioSlider extends StatefulWidget {
  final Stream<Duration> progress$;
  final Stream<Duration?> duration$;

  final Function(int)? moveTo;

  const _AudioSlider({
    Key? key,
    required this.progress$,
    required this.duration$,
    this.moveTo,
  }) : super(key: key);

  @override
  __AudioSliderState createState() => __AudioSliderState();
}

class __AudioSliderState extends State<_AudioSlider> {
  Duration? currentProgress;
  Duration? duration;
  StreamSubscription? progressSub;
  StreamSubscription? durationSub;

  @override
  void initState() {
    super.initState();
    this.progressSub = this
        .widget
        .progress$
        .listen((event) => this.setState(() => this.currentProgress = event));
    this.durationSub = this
        .widget
        .duration$
        .listen((event) => this.setState(() => this.duration = event));
  }

  @override
  void deactivate() {
    this.progressSub?.cancel();
    this.durationSub?.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackShape: CustomTrackShape(),
      ),
      child: Slider(
        activeColor: Colors.white,
        inactiveColor: Colors.white.withOpacity(0.5),
        min: 0.0,
        max: this.duration?.inSeconds.toDouble() ?? 0,
        value: this.currentProgress?.inSeconds.toDouble() ?? 0,
        onChanged: (double value) => this.widget.moveTo == null
            ? () {}
            : this.widget.moveTo!(value.toInt()),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
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
