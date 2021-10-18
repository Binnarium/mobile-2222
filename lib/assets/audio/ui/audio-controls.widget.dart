import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/audio/model/player-playing-state.enum.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({
    Key? key,
    required this.state$,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  final Stream<PlayerPlayingStateEnum> state$;
  final Color color;
  final VoidCallback onPressed;

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

const Map<PlayerPlayingStateEnum, IconData> PlayerStateIcons = {
  PlayerPlayingStateEnum.playing: Icons.pause,
  PlayerPlayingStateEnum.paused: Icons.play_arrow,
  PlayerPlayingStateEnum.completed: Icons.stop_rounded,
  PlayerPlayingStateEnum.loading: Icons.downloading,
};

class _PlayButtonState extends State<PlayButton> {
  StreamSubscription? _iconSub;
  IconData icon = PlayerStateIcons[PlayerPlayingStateEnum.loading]!;

  @override
  void initState() {
    super.initState();
    _iconSub = widget.state$.listen((event) {
      setState(() => icon = PlayerStateIcons[event]!);
    });
  }

  @override
  void dispose() {
    _iconSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlayerControlIcon(
      color: widget.color,
      icon: icon,
      onPressed: () => widget.onPressed(),
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
          child: Icon(icon, size: 28),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            onPrimary: color,
            primary: Colors.white,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4),
            shape: const CircleBorder(),
          ),
        );
}
