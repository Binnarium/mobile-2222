import 'package:flutter/material.dart';
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
  // AudioPlayer? audioPlayer;

  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration(seconds: 2), () {
  //     CurrentAudioProvider audioProvider =
  //         Provider.of<CurrentAudioProvider>(context, listen: false);
  //     if (audioProvider.currentAudio?.path == this.widget.audio.path)
  //       this.setState(() {
  //         audioProvider.player = audioProvider.player;
  //       });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // print(audioProvider.player);
    CurrentAudioProvider audioProvider =
        Provider.of<CurrentAudioProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        /// progress indicator
        if (audioProvider.currentAudio?.path == this.widget.audio.path)
          AudioSlider(
            moveTo: audioProvider.player.changeToSecond,
            positionData$: audioProvider.player.positionData$,
          )
        else
          FakeAudioSlider(),

        /// controls when player connected
        if (audioProvider.currentAudio?.path == this.widget.audio.path)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /// rewind button
              PlayerControlIcon(
                color: this.widget.color,
                icon: Icons.replay_5_rounded,
                onPressed: () =>
                    audioProvider.player.rewind(Duration(seconds: 5)),
              ),

              /// play button
              PlayButton(
                state$: audioProvider.player.playing$,
                color: this.widget.color,
                onPressed: () => audioProvider.player.playOrPause(),
              ),

              /// forward button
              PlayerControlIcon(
                color: this.widget.color,
                icon: Icons.forward_5_rounded,
                onPressed: () =>
                    audioProvider.player.forward(Duration(seconds: 5)),
              ),
            ],
          )

        /// to initialize the audio
        else
          PlayerControlIcon(
              color: this.widget.color,
              icon: Icons.play_arrow,
              onPressed: () async {
                // final AudioPlayer? player =
                //     await audioProvider.setAudio(this.widget.audio);
                this.setState(() {});
                audioProvider.setAudio(this.widget.audio).then((value) {});
              }),
      ],
    );
  }
}
