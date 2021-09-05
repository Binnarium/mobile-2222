import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/audio/model/audio-position.model.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class FakeAudioSlider extends AudioSlider {
  FakeAudioSlider()
      : super(
          positionData$: null,
          moveTo: null,
        );
}

class AudioSlider extends StatefulWidget {
  final Stream<AudioPositionData>? positionData$;
  final Function(int)? moveTo;
  const AudioSlider({
    Key? key,
    this.positionData$,
    this.moveTo,
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
    if (this.widget.positionData$ != null)
      this.positionDataSub = this.widget.positionData$!.listen((event) {
        this.setState(() => this.positionData = event);
        print(event);
      });
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
            activeColor: Colors2222.white,
            inactiveColor: Colors2222.white.withOpacity(0.5),
            min: 0.0,
            max: this.positionData.duration.inSeconds.toDouble(),
            value: this.positionData.position.inSeconds.toDouble(),
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
              this.positionData.position.toString().split(".")[0],
              style: textTheme.bodyText2,
            ),
            Text(
              this.positionData.duration.toString().split(".")[0],
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
