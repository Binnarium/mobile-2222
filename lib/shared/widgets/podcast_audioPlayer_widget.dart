import 'package:lab_movil_2222/providers/audioPlayer_provider.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PodcastAudioPlayer extends StatefulWidget {
  final String? audioUrl;
  final Color color;
  final AudioPlayerProvider audioProvider;
  final String? description;
  PodcastAudioPlayer(
      {Key? key,
      this.audioUrl,
      this.description,
      required this.color,
      required this.audioProvider})
      : super(key: key);

  @override
  __PodcastAudioPlayerState createState() => __PodcastAudioPlayerState();
}

class __PodcastAudioPlayerState extends State<PodcastAudioPlayer> {
  late AudioPlayer audioPlayer;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  Icon _playIcon = Icon(Icons.play_arrow_rounded);

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await this.widget.audioProvider.setAudioSource(this.widget.audioUrl!);
    this.widget.audioProvider.player.positionStream.listen((event) {
      setState(() {
        _position = event;
      });
    });
    this.widget.audioProvider.player.durationStream.listen((event) {
      setState(() {
        _duration = event!;
      });
    });
  }

  @override
  void dispose() {
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    this.widget.audioProvider.dispose();
    print("Audio provider disposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    audioPlayer = this.widget.audioProvider.player;
    if (this.widget.audioUrl != null) {
      return _podcastContainer(size);
    }
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: (Text("No podcast Link available")));
  }

  _podcastContainer(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 30),
      child: Container(
        width: size.width * 0.8,
        child: Column(
          children: [
            _textContent(this.widget.description, size),
            SizedBox(height: 30),
            Container(
              child: Container(
                width: size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 20,
                      padding: EdgeInsets.only(bottom: 5),
                      child: _slider(),
                    ),
                    Container(
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
                    SizedBox(
                      height: 5,
                    ),
                    _podcastButtons(audioPlayer, size),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _textContent(String? description, Size size) {
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      // width: size.width * 0.5,
      child: (description == null)
          ? Text('No description Available')
          : Markdown2222(data: description),
    );
  }

  _podcastButtons(AudioPlayer controller, Size size) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildVideoButton(
            Icon(
              Icons.replay_5_rounded,
            ),
            _rewind5Seconds,
            size),
        _buildVideoButton(_playIcon, _playOrPause, size),
        _buildVideoButton(
            Icon(Icons.forward_5_rounded), _forward5Seconds, size),
      ],
    );
  }

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

  Future _rewind5Seconds() async => (_goToPosition((currentPosition) {
        if (currentPosition - Duration(seconds: 5) <= Duration.zero) {
          return Duration.zero;
        }
        return currentPosition - Duration(seconds: 5);
      }));
  Future _forward5Seconds() async => (_goToPosition((currentPosition) {
        if (currentPosition + Duration(seconds: 5) >= audioPlayer.duration!) {
          return audioPlayer.duration!;
        }
        return currentPosition + Duration(seconds: 5);
      }));

  Future _playOrPause() async {
    if (audioPlayer.playing) {
      if (audioPlayer.position >= audioPlayer.duration!) {
        setState(() {
          audioPlayer.seek(Duration.zero);
          _playIcon = Icon(Icons.pause_rounded);
          audioPlayer.play();
        });
      } else {
        setState(() {
          _playIcon = Icon(Icons.play_arrow_rounded);
          audioPlayer.pause();
        });
      }
    } else {
      setState(() {
        _playIcon = Icon(Icons.pause_rounded);
        audioPlayer.play();
      });
    }
  }

  Future _goToPosition(
    Duration Function(Duration currentPosition) builder,
  ) async {
    final currentPosition = audioPlayer.position;
    final newPosition = builder(currentPosition);

    await audioPlayer.seek(newPosition);
  }

  _slider() {
    return new SliderTheme(
      data: SliderThemeData(
        trackShape: CustomTrackShape(),
      ),
      child: new Slider(
        activeColor: Colors.white,
        inactiveColor: Colors.white.withOpacity(0.5),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        value: this.widget.audioProvider.position!.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            _changeToSecond(value.toInt());
            value = value;
          });
        },
      ),
    );
  }

  void _changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    audioPlayer.seek(newDuration);
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
