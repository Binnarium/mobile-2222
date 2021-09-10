import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/themes/colors.dart';

import 'gamification-item.widget.dart';

/// widget that contains a list of the player's gammification
/// - [player] is required to avoid the use of the user stream service
class PlayerGamification extends StatelessWidget {
  final PlayerModel player;

  PlayerGamification({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numberProactivity = this.player.clubhouseAwards.length +
        this.player.projectAwards.length +
        this.player.contributionsAwards.length;

    return Column(
      children: [
        /// player's gammification
        GamificationWidget(
          numberOfMedals: numberProactivity,
          label: 'Nivel de Proactividad'.toUpperCase(),
          image: (numberProactivity < 10)
              ? CoinsImages.redCoin()
              : (numberProactivity < 20)
                  ? CoinsImages.yellowCoin()
                  : CoinsImages.greenCoin(),
        ),

        Divider(
          thickness: 1,
          height: 64,
          color: Colors2222.white.withOpacity(0.5),
        ),

        GamificationWidget(
          numberOfMedals: this.player.contributionsAwards.length,
          label: 'Premios Obtenidos'.toUpperCase(),
          image: CoinsImages.contribution(),
        ),

        SizedBox(height: 40),

        GamificationWidget(
          numberOfMedals: this.player.clubhouseAwards.length,
          label: 'Medallas Clubhouse'.toUpperCase(),
          image: CoinsImages.clubhouse(),
        ),
        SizedBox(height: 40),

        GamificationWidget(
          numberOfMedals: this.player.projectAwards.length,
          label: 'Medallas Proyectos'.toUpperCase(),
          image: CoinsImages.project(),
        ),
      ],
    );
  }
}
