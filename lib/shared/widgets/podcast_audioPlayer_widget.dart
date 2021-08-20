import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/providers/audioPlayer_provider.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:provider/provider.dart';

class PodcastAudioPlayer extends StatefulWidget {
  final AudioDto audio;
  final Color color;

  PodcastAudioPlayer({
    Key? key,
    required this.audio,
    this.color = Colors2222.primary,
  }) : super(key: key);

  @override
  __PodcastAudioPlayerState createState() => __PodcastAudioPlayerState();
}

class __PodcastAudioPlayerState extends State<PodcastAudioPlayer> {
  AudioPlayerProvider? _audioProviderInstance;

  AudioPlayerProvider get audioProvider {
    if (this._audioProviderInstance == null)
      this._audioProviderInstance = Provider.of<AudioPlayerProvider>(context);
    return this._audioProviderInstance!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          /// progress indicator
          if (this.audioProvider.currentAudio?.path == this.widget.audio.path)
            Container(
              child: _AudioSlider(
                positionData$: this.audioProvider.positionData$,
                moveTo: this.audioProvider.changeToSecond,
              ),
            )
          else
            _FakeAudioSlider(),

          /// controls
          if (this.audioProvider.currentAudio?.path == this.widget.audio.path)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// rewind button
                _PlayerControlIcon(
                  color: this.widget.color,
                  icon: Icons.replay_5_rounded,
                  onPressed: () => this.audioProvider.rewind(5),
                ),

                /// play button
                _PlayButton(
                  state$: this.audioProvider.playing$,
                  color: this.widget.color,
                  onPressed: () => this.audioProvider.playOrPause(),
                ),

                /// forward button
                _PlayerControlIcon(
                  color: this.widget.color,
                  icon: Icons.forward_5_rounded,
                  onPressed: () => this.audioProvider.forward(5),
                ),
              ],
            )
          else

            /// to initialize the audio
            _PlayerControlIcon(
              color: this.widget.color,
              icon: Icons.play_arrow,
              onPressed: () {
                /// implemented setstate to activate the icons of the podcast
                setState(
                  () {
                    audioProvider.setAudio(this.widget.audio);
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatefulWidget {
  final Stream<PlayerState> state$;
  final Color color;
  final VoidCallback onPressed;

  _PlayButton({
    Key? key,
    required this.state$,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  __PlayButtonState createState() => __PlayButtonState();
}

const Map<PlayerState, IconData> PlayerStateIcons = {
  PlayerState.playing: Icons.pause,
  PlayerState.paused: Icons.play_arrow,
  PlayerState.completed: Icons.replay,
  PlayerState.loading: Icons.downloading,
};

class __PlayButtonState extends State<_PlayButton> {
  StreamSubscription? _iconSub;
  IconData icon = PlayerStateIcons[PlayerState.loading]!;

  @override
  void initState() {
    super.initState();
    this._iconSub = this.widget.state$.listen((event) {
      print(event);
      this.setState(() => this.icon = PlayerStateIcons[event]!);
    });
  }

  @override
  void dispose() {
    this._iconSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _PlayerControlIcon(
      color: this.widget.color,
      icon: this.icon,
      onPressed: () => this.widget.onPressed(),
    );
  }
}

class _PlayerControlIcon extends ElevatedButton {
  _PlayerControlIcon({
    Key? key,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) : super(
          key: key,
          child: Icon(icon),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            onPrimary: color,
            primary: Colors.white,
            alignment: Alignment.center,
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
          ),
        );
}

class _FakeAudioSlider extends _AudioSlider {
  _FakeAudioSlider()
      : super(
          positionData$: Stream.value(
            PositionData(
              bufferedPosition: Duration(),
              duration: Duration(),
              position: Duration(),
            ),
          ),
        );
}

class _AudioSlider extends StatefulWidget {
  final Stream<PositionData> positionData$;

  final Function(int)? moveTo;

  const _AudioSlider({
    Key? key,
    required this.positionData$,
    this.moveTo,
  }) : super(key: key);

  @override
  __AudioSliderState createState() => __AudioSliderState();
}

class __AudioSliderState extends State<_AudioSlider> {
  PositionData? positionData;
  StreamSubscription? positionDataSub;

  @override
  void initState() {
    super.initState();
    this.positionDataSub = this
        .widget
        .positionData$
        .listen((event) => this.setState(() => this.positionData = event));
  }

  @override
  void deactivate() {
    this.positionDataSub?.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SliderTheme(
          data: SliderThemeData(
            trackShape: _CustomTrackShape(),
          ),
          child: Slider(
            activeColor: Colors.white,
            inactiveColor: Colors.white.withOpacity(0.5),
            min: 0.0,
            max: this.positionData?.duration.inSeconds.toDouble() ?? 0,
            value: this.positionData?.position.inSeconds.toDouble() ?? 0,
            onChanged: (value) {
              if (this.widget.moveTo != null)
                this.widget.moveTo!(value.toInt());
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
              this.positionData?.position.toString().split(".")[0] ?? '0:00',
              style: textTheme.bodyText2,
            ),
            Text(
              this.positionData?.duration.toString().split(".")[0] ?? '0:00',
              style: textTheme.bodyText2,
            ),
          ],
        ),
      ],
    );
  }
}

class _CustomTrackShape extends RoundedRectSliderTrackShape {
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
