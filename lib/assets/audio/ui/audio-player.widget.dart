import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lab_movil_2222/assets/audio/model/audio-player.extension.dart';
import 'package:lab_movil_2222/assets/audio/services/current-audio.provider.dart';
import 'package:lab_movil_2222/assets/audio/ui/audio-controls.widget.dart';
import 'package:lab_movil_2222/assets/audio/ui/audio-slider.widget.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:provider/provider.dart';

class AudioPlayerWidget extends StatefulWidget {
  /// audio to play
  final AudioDto audio;

  /// style player with a proper color
  final Color color;

  AudioPlayerWidget({
    Key? key,
    required this.audio,
    this.color = Colors2222.primary,
  }) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  StreamSubscription? _currentPlayerSub;

  CurrentAudioProvider get audioProvider =>
      Provider.of<CurrentAudioProvider>(context, listen: false);

  AudioPlayer? player;

  @override
  void initState() {
    super.initState();
    _currentPlayerSub = audioProvider.currentAudio$.listen(
      (currentAudio) {
        if (mounted) {
          setState(() {
            if (currentAudio?.path == widget.audio.path)
              player = audioProvider.player;
            else
              player = null;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _currentPlayerSub?.cancel();
    audioProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        /// progress indicator
        if (player != null) ...[
          AudioSlider(
            player: player!,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /// rewind button
              PlayerControlIcon(
                color: widget.color,
                icon: Icons.replay_5_rounded,
                onPressed: () => player!.rewind(Duration(seconds: 5)),
              ),

              /// play button
              PlayButton(
                state$: player!.playing$,
                color: widget.color,
                onPressed: () => player!.playOrPause(),
              ),

              /// forward button
              PlayerControlIcon(
                color: widget.color,
                icon: Icons.forward_5_rounded,
                onPressed: () => player!.forward(Duration(seconds: 5)),
              ),
            ],
          )
        ] else ...[
          FakeAudioSlider(),
          PlayerControlIcon(
            color: widget.color,
            icon: Icons.play_arrow,
            onPressed: () => audioProvider.setAudio(widget.audio),
          ),
        ],
      ],
    );
  }
}
