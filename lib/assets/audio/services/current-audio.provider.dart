import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lab_movil_2222/assets/models/asset.dto.dart';
import 'package:rxdart/subjects.dart';

class CurrentAudioProvider {
  CurrentAudioProvider() {
    AudioSession.instance.then((session) {
      // Inform the operating system of our app's audio attributes etc.
      // We pick a reasonable default for an app that plays speech.
      session.configure(const AudioSessionConfiguration.speech());
    });

    // Listen to errors during playback.
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
  }

  /// manage controls
  final AudioPlayer player = AudioPlayer();

  // ignore: close_sinks
  final BehaviorSubject<AudioDto?> _currentAudioSink =
      BehaviorSubject<AudioDto?>.seeded(null);

  Stream<AudioDto?> get currentAudio$ => _currentAudioSink.stream;

  // late AudioSession player;

  // ignore: avoid_void_async
  void setAudio(AudioDto audio) async {
    try {
      /// load audio to player
      _currentAudioSink.add(audio);
      await player.setUrl(audio.url);
      await player.play();
    } catch (e) {
      print('Error loading audio source: $e');
    }
  }

  /// method to stop and close player, if you want to only stop the current audio
  // ignore: comment_references
  /// use the [playOrPause] method
  // ignore: avoid_void_async
  void close() async {
    _currentAudioSink.add(null);
    await player.stop();
    await player.dispose();
  }
}
