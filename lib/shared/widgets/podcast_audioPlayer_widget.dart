import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/providers/audioPlayer_provider.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
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

    /// cant dispose, if this line is uncommented this will happen: next cities
    /// podcast will have the same stop environment
    // this.audioProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          /// progress indicator
          if (this.audioProvider.current?.path == this.widget.audio.path)
            Container(
              child: _AudioSlider(
                duration$: this.audioProvider.duration$!,
                progress$: this.audioProvider.position$!,
                // moveTo: (position) {},
                audioProvider: this.audioProvider,
              ),
            )
          else
            _FakeAudioSlider(),

          /// controls
          if (this.audioProvider.current?.path == this.widget.audio.path)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // rewind button
                _buildVideoButton(
                    Icon(
                      Icons.replay_5_rounded,
                    ),
                    // _rewind5Seconds,
                    () {
                  this.audioProvider.rewind5Seconds();
                }, size),

                // play button
                _buildVideoButton(
                    _playIcon, () => audioProvider.playOrPause(), size),

                // forward button
                _buildVideoButton(Icon(Icons.forward_5_rounded),
                    () => this.audioProvider.forward5Seconds(), size),
              ],
            )
          else

            /// to initialize the audio
            _buildVideoButton(_playIcon,
                () => audioProvider.setAudio(this.widget.audio), size),
        ],
      ),
    );
  }

  //TODO: Change to class
  Widget _buildVideoButton(Widget child, Function() onPressed, Size size) =>
      Container(
        // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        width: size.width * 0.1,
        height: size.height * 0.07,
        child: ElevatedButton(
          onPressed: onPressed,
          child: child,
          style: ElevatedButton.styleFrom(
            onPrimary: this.widget.color,
            primary: Colors.white,
            alignment: Alignment.center,
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
          ),
        ),
      );

  AudioPlayerProvider get audioProvider {
    if (this._audioProviderInstance == null)
      this._audioProviderInstance = Provider.of<AudioPlayerProvider>(context);
    return this._audioProviderInstance!;
  }
}

class _FakeAudioSlider extends _AudioSlider {
  _FakeAudioSlider()
      : super(
          progress$: Stream.value(Duration(seconds: 0)),
          duration$: Stream.value(Duration(seconds: 0)),
        );
}

class _AudioSlider extends StatefulWidget {
  final Stream<Duration> progress$;
  final Stream<Duration?> duration$;
  final AudioPlayerProvider? audioProvider;

  final Function(int)? moveTo;

  const _AudioSlider({
    Key? key,
    required this.progress$,
    required this.duration$,
    this.moveTo,
    this.audioProvider,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SliderTheme(
          data: SliderThemeData(
            trackShape: CustomTrackShape(),
          ),
          child: Slider(
            activeColor: Colors.white,
            inactiveColor: Colors.white.withOpacity(0.5),
            min: 0.0,
            max: this.duration?.inSeconds.toDouble() ?? 0,
            value: this.currentProgress?.inSeconds.toDouble() ?? 0,
            onChanged: (double value) {
              setState(() {
                this.widget.audioProvider?.changeToSecond(value.toInt());
                value = value;
              });
            },
          ),
        ),

        /// current time, and time remaining
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentProgress.toString().split(".")[0],
              style: korolevFont.bodyText2,
            ),
            Text(
              duration.toString().split(".")[0],
              style: korolevFont.bodyText2,
            ),
          ],
        ),
      ],
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
