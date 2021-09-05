import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';

class CurrentAudioProvider {
  /// manage controls
  final AudioPlayer player = AudioPlayer();

  AudioDto? _currentAudio;

  AudioDto? get currentAudio => this._currentAudio;

  // late AudioSession player;
  CurrentAudioProvider() {
    AudioSession.instance.then((session) {
      // Inform the operating system of our app's audio attributes etc.
      // We pick a reasonable default for an app that plays speech.
      session.configure(AudioSessionConfiguration.speech());
    });

    // Listen to errors during playback.
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
  }

  Future<AudioPlayer?> setAudio(AudioDto audio) async {
    try {
      /// load audio to player
      this._currentAudio = audio;
      await player.setUrl(audio.url);
      await player.play();
      return this.player;
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  /// method to stop and close player, if you want to only stop the current audio
  /// use the [playOrPause] method
  Future<void> close() async {
    this._currentAudio = null;
    await this.player.stop();
    await this.player.dispose();
  }
}
