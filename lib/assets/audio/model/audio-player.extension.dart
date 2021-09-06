import 'dart:math';

import 'package:just_audio/just_audio.dart';
import 'package:lab_movil_2222/assets/audio/model/player-playing-state.enum.dart';
import 'package:rxdart/rxdart.dart';

import 'audio-position.model.dart';

extension Lab2222AudioPlayerExtension on AudioPlayer {
  Stream<PlayerPlayingStateEnum> get playing$ => this.playerStateStream.map(
        /// turn events into a player state
        (event) {
          final ProcessingState processingState = event.processingState;
          if (processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering)
            return PlayerPlayingStateEnum.loading;
          if (processingState == ProcessingState.completed)
            return PlayerPlayingStateEnum.completed;
          if (event.playing) return PlayerPlayingStateEnum.playing;
          return PlayerPlayingStateEnum.paused;
        },
      );

  Stream<AudioPositionData> get positionData$ =>
      Rx.combineLatest3<Duration, Duration, Duration?, AudioPositionData>(
        this.positionStream,
        this.bufferedPositionStream,
        this.durationStream,
        (position, bufferedPosition, duration) => AudioPositionData(
          position: position,
          bufferedPosition: bufferedPosition,
          duration: duration ?? Duration.zero,
        ),
      );

  /// make pointer go backward by a specific amount of [time]
  Future rewind(Duration time) async {
    /// add bot positions
    final int newSeconds = max(this.position.inSeconds - time.inSeconds, 0);
    final Duration newPosition = Duration(seconds: newSeconds);

    /// move to position
    await this.seek(newPosition);
  }

  /// make pointer go forward by a specific amount of [time]
  Future forward(Duration time) async {
    /// add bot positions
    final int newSeconds = min(
      this.position.inSeconds + time.inSeconds,
      this.duration?.inSeconds ?? 0,
    );

    final Duration newPosition = Duration(seconds: newSeconds);

    /// move to position
    await this.seek(newPosition);
  }

  /// method to change to a specific second (used on slider)
  Future<void> changeToSecond(int second) async {
    Duration newDuration = Duration(seconds: second);
    await this.seek(newDuration);
  }

  /// method to play or pause the audio
  Future<void> playOrPause() async {
    PlayerPlayingStateEnum? playing = await this.playing$.first;

    /// if playing, then pause
    if (playing == PlayerPlayingStateEnum.playing) {
      await this.pause();
      return;
    }

    /// if paused then play
    if (playing == PlayerPlayingStateEnum.paused) {
      await this.play();
      return;
    }

    /// if replay, then move to start and play again
    if (playing == PlayerPlayingStateEnum.completed) {
      await this.seek(Duration.zero);
      await this.play();
      return;
    }
  }
}
