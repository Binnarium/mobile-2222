import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/audio/ui/audio-player.widget.dart';
import 'package:lab_movil_2222/player/gamification-explanation/models/gamification-explanation.model.dart';
import 'package:lab_movil_2222/player/gamification-explanation/uid/gamification-explanation-wrapper.dart';

/// aprobe explanation using a card to display its content
class AprobeAudioExplanation extends GamificationExplanationWrapper {
  AprobeAudioExplanation({
    Key? key,
  }) : super(
          key: key,
          builder: (GamificationExplanationModel explanation) =>
              AudioPlayerWidget(audio: explanation.audio!),
        );
}
