import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';
import 'package:audio_session/audio_session.dart';

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
    return (Text("No podcast Link available"));
  }

  _podcastContainer(Size size) {
    return Column(
      children: [
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            _textContent(this.widget.description, size),
            // SizedBox(height: 30),

            Container(
              width: size.width * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/icons/podcast_icon.png'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _podcastButtons(_player, size),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
      ],
    );
  }

  _textContent(String? description, Size size) {
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      width: size.width * 0.5,
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
        _buildVideoButton(
            (_player.playerState.playing)
                ? Icon(Icons.pause_rounded)
                : Icon(Icons.play_arrow_rounded),
            _playOrPause,
            size),
        _buildVideoButton(
            Icon(Icons.forward_5_rounded), _forward5Seconds, size),
      ],
    );
  }

  Widget _buildVideoButton(Widget child, Function() onPressed, Size size) =>
      Container(
        child: Container(
          width: size.width * 0.1,
          child: ElevatedButton(
            onPressed: onPressed,
            child: child,
            style: ElevatedButton.styleFrom(
              onPrimary: this.widget.color,
              primary: Colors.white,
              alignment: Alignment.center,
              padding: EdgeInsets.all(0),
            ),
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
        print("reiniciar audio");
        setState(() {
          _player.seek(Duration.zero);
          _player.play();
        });
      } else {
        setState(() {
          _player.pause();
        });
      }
    } else {
      setState(() {
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
}
