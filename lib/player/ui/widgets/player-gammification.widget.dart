import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/themes/colors.dart';

import 'gamification-item.widget.dart';

/// widget that contains a list of the player's gammification
/// - [player] is required to avoid the use of the user stream service
class PlayerGammification extends StatelessWidget {
  final PlayerModel player;

  PlayerGammification({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numberProjects = this.player.projectAwards.length;
    int numberClubhouses = this.player.clubhouseAwards.length;
    int numberProactivity = numberProjects + numberClubhouses;

    return ListBody(
      children: [
        /// player's gammification
        GammificationWidget(
          number: numberProactivity,
          kind: GammificationKind.proactivity,
        ),

        SizedBox(
          height: 32,
        ),
        Container(
          height: 1,
          color: Colors2222.white.withOpacity(0.5),
        ),
        SizedBox(
          height: 32,
        ),

        GammificationWidget(
          number: numberProjects,
          kind: GammificationKind.prizes,
          image: AssetImage('assets/gamification/2222_monedas.png'),
        ),
        SizedBox(
          height: 40,
        ),

        GammificationWidget(
          number: numberClubhouses,
          kind: GammificationKind.clubhouse,
          image: AssetImage('assets/gamification/2222_medalla-clubhouse.png'),
        ),
        SizedBox(
          height: 64,
        ),
      ],
    );
  }
}
