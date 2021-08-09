import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class PodcastAudioPlayer extends StatefulWidget {
  final String? audioUrl;
  final Color color;
  final String? description;
  PodcastAudioPlayer(
      {Key? key, this.audioUrl, this.description, required this.color})
      : super(key: key);

  @override
  __PodcastAudioPlayerState createState() => __PodcastAudioPlayerState();
}

class __PodcastAudioPlayerState extends State<PodcastAudioPlayer> {
  final AudioPlayer _player = AudioPlayer();
  Duration _duration = new Duration();
  Duration _position = new Duration();
  Icon _playIcon = Icon(Icons.play_arrow_rounded);

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    if (this.widget.audioUrl == null) {
      print("error, no podcast link available");
    } else {
      try {
        await _player
            .setAudioSource(AudioSource.uri(Uri.parse(this.widget.audioUrl!)));
      } catch (e) {
        print("Error loading audio source: $e");
      }
    }
    // Try to load audio from a source and catch any errors.
    _player.positionStream.listen((event) {
      setState(() {
        _position = event;
      });
    });
    _player.durationStream.listen((event) {
      setState(() {
        _duration = event!;
      });
    });
  }

  @override
  void dispose() {
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    _player.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                      image: AssetImage('assets/icons/podcast_icon.png'),
                    ),
                    SizedBox(
                      width: (size.width < 325) ? 0 : size.width * 0.05,
                    ),
                    Container(
                      width: (size.width < 325)
                          ? size.width * 0.45
                          : size.width * 0.55,
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
                          _podcastButtons(_player, size),
                        ],
                      ),
                    ),
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
      child: Text(
        (description == null) ? 'No description Available' : description,
        style: korolevFont.bodyText1?.apply(),
      ),
    );
  }

  _podcastButtons(AudioPlayer controller, Size size) {
    return Row(
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
        if (currentPosition + Duration(seconds: 5) >= _player.duration!) {
          return _player.duration!;
        }
        return currentPosition + Duration(seconds: 5);
      }));

  Future _playOrPause() async {
    if (_player.playing) {
      if (_player.position >= _player.duration!) {
        setState(() {
          _player.seek(Duration.zero);
          _playIcon = Icon(Icons.pause_rounded);
          _player.play();
        });
      } else {
        setState(() {
          _playIcon = Icon(Icons.play_arrow_rounded);
          _player.pause();
        });
      }
    } else {
      setState(() {
        _playIcon = Icon(Icons.pause_rounded);
        _player.play();
      });
    }
  }

  Future _goToPosition(
    Duration Function(Duration currentPosition) builder,
  ) async {
    final currentPosition = _player.position;
    final newPosition = builder(currentPosition);

    await _player.seek(newPosition);
  }

  _slider() {
    return SliderTheme(
        data: SliderThemeData(
          trackShape: CustomTrackShape(),
        ),
        child: Slider(
            activeColor: Colors.white,
            inactiveColor: Colors.white,
            min: 0.0,
            max: _duration.inSeconds.toDouble(),
            value: _position.inSeconds.toDouble(),
            onChanged: (double value) {
              setState(() {
                _changeToSecond(value.toInt());
                value = value;
              });
            }));
  }

  void _changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    _player.seek(newDuration);
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
