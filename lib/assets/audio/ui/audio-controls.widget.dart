import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/audio/model/player-playing-state.enum.dart';

class PlayButton extends StatefulWidget {
  final Stream<PlayerPlayingStateEnum> state$;
  final Color color;
  final VoidCallback onPressed;

  PlayButton({
    Key? key,
    required this.state$,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

const Map<PlayerPlayingStateEnum, IconData> PlayerStateIcons = {
  PlayerPlayingStateEnum.playing: Icons.pause,
  PlayerPlayingStateEnum.paused: Icons.play_arrow,
  PlayerPlayingStateEnum.completed: Icons.replay,
  PlayerPlayingStateEnum.loading: Icons.downloading,
};

class _PlayButtonState extends State<PlayButton> {
  StreamSubscription? _iconSub;
  IconData icon = PlayerStateIcons[PlayerPlayingStateEnum.loading]!;

  @override
  void initState() {
    super.initState();
    this._iconSub = this.widget.state$.listen((event) {
      this.setState(() => this.icon = PlayerStateIcons[event]!);
    });
  }

  @override
  void dispose() {
    this._iconSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlayerControlIcon(
      color: this.widget.color,
      icon: this.icon,
      onPressed: () => this.widget.onPressed(),
    );
  }
}

class PlayerControlIcon extends ElevatedButton {
  PlayerControlIcon({
    Key? key,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) : super(
          key: key,
          child: Icon(icon),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            onPrimary: color,
            primary: Colors.white,
            alignment: Alignment.center,
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
          ),
        );
}
