import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

class AudioPlayerProvider with ChangeNotifier {
  AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => this._player;

  Future<void> setAudioSource(String url) async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.

    final session = await AudioSession.instance;

    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    {
      try {
        await _player.setAudioSource(AudioSource.uri(Uri.parse(url)));
      } catch (e) {
        print("Error loading audio source: $e");
      }
    }
    notifyListeners();
  }

  Duration? get duration => this._player.duration;

  Duration? get position => this._player.position;
}
