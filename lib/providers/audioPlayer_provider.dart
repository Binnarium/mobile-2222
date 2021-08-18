import 'dart:math';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:rxdart/rxdart.dart';

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData({
    required this.position,
    required this.bufferedPosition,
    required this.duration,
  });
}

enum PlayerState {
  paused,
  playing,
  completed,
  loading,
}

class AudioPlayerProvider with ChangeNotifier {
  /// manage controls
  final AudioPlayer _player = AudioPlayer();

  AudioDto? _currentAudio;

  AudioDto? get currentAudio => this._currentAudio;

  // late AudioSession player;
  AudioPlayerProvider() {
    AudioSession.instance.then((session) {
      // Inform the operating system of our app's audio attributes etc.
      // We pick a reasonable default for an app that plays speech.
      session.configure(AudioSessionConfiguration.speech());
    });

    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
  }

  Future<void> setAudio(AudioDto audio) async {
    this._currentAudio = audio;

    try {
      /// load audio to player
      await _player.setUrl(audio.url);
      await _player.play();
      notifyListeners();
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  /// method to stop and close player, if you want to only stop the current audio
  /// use the [playOrPause] method
  close() {
    this._player.stop();
    // this.player.dispose();
    this._currentAudio = null;
    notifyListeners();
  }

  Future rewind(int seconds) async {
    /// validate there is a current playing track
    if (this._currentAudio == null) return;

    /// add bot positions
    final int newSeconds = max(_player.position.inSeconds - seconds, 0);
    final Duration newPosition = Duration(seconds: newSeconds);

    /// move to position
    await _player.seek(newPosition);
  }

  Future forward(int seconds) async {
    /// validate there is a current playing track
    if (this._currentAudio == null) return;

    /// add bot positions
    final int newSeconds = _player.duration == null
        ? _player.position.inSeconds + seconds
        : min(
            _player.position.inSeconds + seconds, _player.duration!.inSeconds);
    final Duration newPosition = Duration(seconds: newSeconds);

    /// move to position
    await _player.seek(newPosition);
  }

  /// method to play or pause the audio
  Future<void> playOrPause() async {
    PlayerState? playing = await this.playing$.first;
    print(playing);
    print(playing);

    /// if playing, then pause
    if (playing == PlayerState.playing) {
      await this._player.pause();
      notifyListeners();
      return;
    }

    /// if paused then play
    if (playing == PlayerState.paused) {
      await this._player.play();
      notifyListeners();
      return;
    }

    /// if replay, then move to start and play again
    if (playing == PlayerState.completed) {
      await this._player.seek(Duration.zero);
      await this._player.play();
      notifyListeners();
      return;
    }
  }

  /// method to change to a specific second (used on slider)
  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    this._player.seek(newDuration);
  }

  Stream<PositionData> get positionData$ =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        this._player.positionStream,
        this._player.bufferedPositionStream,
        this._player.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position: position,
          bufferedPosition: bufferedPosition,
          duration: duration ?? Duration.zero,
        ),
      );

  Stream<PlayerState> get playing$ =>
      this._player.playerStateStream.map((event) {
        final ProcessingState processingState = event.processingState;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering)
          return PlayerState.loading;
        if (processingState == ProcessingState.completed)
          return PlayerState.completed;
        if (event.playing) return PlayerState.playing;
        return PlayerState.paused;
      });
}
