import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';

class AudioPlayerProvider with ChangeNotifier {
  /// manage controls
  final AudioPlayer player = AudioPlayer();

  AudioDto? _currentAudio;

  // late AudioSession player;
  AudioPlayerProvider() {
    AudioSession.instance.then(
      (session) =>
          // Inform the operating system of our app's audio attributes etc.
          // We pick a reasonable default for an app that plays speech.
          session.configure(AudioSessionConfiguration.speech()),
    );

    // Listen to errors during playback.
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
  }

  Future<bool> setAudio(AudioDto audio) async {
    this._currentAudio = audio;
    try {
      /// load audio to player
      await player.setAudioSource(AudioSource.uri(Uri.parse(audio.url)));
      this.player.play();
      return true;
    } catch (e) {
      print("Error loading audio source: $e");
      return false;
    } finally {
      notifyListeners();
    }
  }

  Stream<Duration?>? get duration$ => this.player.durationStream;

  Stream<Duration>? get position$ => this.player.positionStream;

  AudioDto? get current => this._currentAudio;

  close() {
    this._currentAudio = null;
    this.player.stop();
  }
}
