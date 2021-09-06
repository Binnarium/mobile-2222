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
    this._currentPlayerSub = this.audioProvider.currentAudio$.listen(
      (currentAudio) {
        if (this.mounted)
          this.setState(() {
            if (currentAudio?.path == this.widget.audio.path)
              this.player = audioProvider.player;
            else
              this.player = null;
          });
      },
    );
  }

  @override
  void dispose() {
    this._currentPlayerSub?.cancel();
    this.audioProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        /// progress indicator
        if (this.player != null) ...[
          AudioSlider(
            player: this.player!,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /// rewind button
              PlayerControlIcon(
                color: this.widget.color,
                icon: Icons.replay_5_rounded,
                onPressed: () => this.player!.rewind(Duration(seconds: 5)),
              ),

              /// play button
              PlayButton(
                state$: this.player!.playing$,
                color: this.widget.color,
                onPressed: () => this.player!.playOrPause(),
              ),

              /// forward button
              PlayerControlIcon(
                color: this.widget.color,
                icon: Icons.forward_5_rounded,
                onPressed: () => this.player!.forward(Duration(seconds: 5)),
              ),
            ],
          )
        ] else ...[
          FakeAudioSlider(),
          PlayerControlIcon(
            color: this.widget.color,
            icon: Icons.play_arrow,
            onPressed: () => audioProvider.setAudio(this.widget.audio),
          ),
        ],
      ],
    );
  }
}
