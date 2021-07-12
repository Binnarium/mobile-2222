import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';
import 'package:audio_session/audio_session.dart';

class PodcastAudioPlayer extends StatefulWidget {
  final String audioUrl;
  final String? description;
  PodcastAudioPlayer({Key? key, required this.audioUrl, this.description})
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
    // Try to load audio from a source and catch any errors.
    try {
      await _player
          .setAudioSource(AudioSource.uri(Uri.parse(this.widget.audioUrl)));
    } catch (e) {
      print("Error loading audio source: $e");
    }
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
    return _podcastContainer(size);
  }

  _podcastContainer(Size size) {
    return Column(
      children: [
        SizedBox(height: 30),
        _textContent(this.widget.description, size),
        SizedBox(height: 30),
        Material(
            type: MaterialType.circle,
            color: Colors.transparent,
            child: InkResponse(
              onTap: () async {
                if (_player.playing) {
                  print("entró a pause");
                  if (_player.position >= _player.duration!) {
                    print("reiniciar audio");
                    _player.seek(Duration.zero);
                    _player.play();
                  } else {
                    _player.pause();
                  }
                } else {
                  print("entró a play");

                  _player.play();
                }
                print('duracion de audio: ${_player.duration}');
                print('player state: ${_player.position}');
              },
              child: Image(
                image: AssetImage('assets/icons/podcast_icon.png'),
              ),
            )),
        SizedBox(height: 20),
        Text(
          'Escucha el podcast',
          style: korolevFont.headline6?.apply(),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  _textContent(String? description, Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 30),
      child: Text(
        (description == null) ? '' : description,
        style: korolevFont.bodyText1?.apply(),
      ),
    );
  }
}
