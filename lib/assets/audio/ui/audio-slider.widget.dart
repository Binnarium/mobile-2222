import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lab_movil_2222/assets/audio/model/audio-player.extension.dart';
import 'package:lab_movil_2222/assets/audio/model/audio-position.model.dart';
import 'package:lab_movil_2222/themes/colors.dart';

/// TODO: review how to remove this widget
class FakeAudioSlider extends AudioSlider {
  FakeAudioSlider() : super();
}

class AudioSlider extends StatefulWidget {
  final AudioPlayer? player;

  const AudioSlider({
    Key? key,
    this.player,
  }) : super(key: key);

  @override
  _AudioSliderState createState() => _AudioSliderState();
}

class _AudioSliderState extends State<AudioSlider> {
  AudioPositionData positionData = AudioPositionData.zero();
  StreamSubscription? positionDataSub;

  @override
  void initState() {
    super.initState();
    positionDataSub = widget.player?.positionData$.listen((event) {
      if (mounted) setState(() => positionData = event);
    });
  }

  @override
  void deactivate() {
    positionDataSub?.cancel();
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
            activeColor: Colors2222.white,
            inactiveColor: Colors2222.white.withOpacity(0.5),
            min: 0.0,
            max: positionData.duration.inSeconds.toDouble(),
            value: positionData.position.inSeconds.toDouble(),
            onChanged: (value) {
              widget.player?.changeToSecond(value.toInt());
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
              positionData.position.toString().split('.')[0],
              style: textTheme.bodyText2,
            ),
            Text(
              positionData.duration.toString().split('.')[0],
              style: textTheme.bodyText2,
            ),
          ],
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
