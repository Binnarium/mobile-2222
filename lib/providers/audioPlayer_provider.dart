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
      playOrPause();
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

  ///TODO: method to close the player
  close() {
    this.player.stop();
    // this.player.dispose();
    this._currentAudio = null;
  }

  /// method to rewind 5 secs
  Future rewind5Seconds() async => (_goToPosition((currentPosition) {
        if (currentPosition - Duration(seconds: 5) <= Duration.zero) {
          return Duration.zero;
        }
        return currentPosition - Duration(seconds: 5);
      }));

  /// method to forward to 5 seconds
  Future forward5Seconds() async => (_goToPosition((currentPosition) {
        if (currentPosition + Duration(seconds: 5) >= player.duration!) {
          return player.duration!;
        }
        return currentPosition + Duration(seconds: 5);
      }));

  /// method to play or pause the audio
  Future playOrPause() async {
    if (player.playing) {
      if (player.position >= player.duration!) {
        player.seek(Duration.zero);
        // _playIcon = Icon(Icons.pause_rounded);
        player.play();
      } else {
        // _playIcon = Icon(Icons.play_arrow_rounded);
        player.pause();
      }
    } else {
      // _playIcon = Icon(Icons.pause_rounded);
      player.play();
    }
  }

  /// method to change to a specyfic second (used on slider)
  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    player.seek(newDuration);
  }

  /// method used in forward, rewind, to get the new position in the audio
  Future _goToPosition(
    Duration Function(Duration currentPosition) builder,
  ) async {
    final currentPosition = player.position;
    final newPosition = builder(currentPosition);

    await player.seek(newPosition);
  }
}
