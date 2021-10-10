import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';

class AvatarImage extends StatelessWidget {
  /// constructor
  const AvatarImage({
    Key? key,
    required this.participant,
  }) : super(key: key);

  /// Participant
  final PlayerModel participant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: SizedBox(
        height: 50,
        child: Stack(children: [
          if (participant.avatarImage.url == '')
            const CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/backgrounds/decorations/elipse_profile.png'),
              maxRadius: 40,
            )
          else
            CircleAvatar(
              backgroundImage: NetworkImage(
                participant.avatarImage.url,
              ),
              maxRadius: 40,
            ),
        ]),
      ),
    );
  }
}
