import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/gamification-explanation/uid/aprove-audio-explanation.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/ui/screens/scoreboard.screen.dart';
import 'package:lab_movil_2222/player/ui/widgets/gamification-item.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

/// widget that contains a list of the player's gamification
/// - [player] is required to avoid the use of the user stream service
class PlayerGamification extends StatelessWidget {
  const PlayerGamification({
    Key? key,
    required this.player,
  }) : super(key: key);

  final PlayerModel player;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        /// player's gamification
        ObtainedMedalsCardWidget(
          numberOfMedals: player.proactivity,
          label: 'Nivel de Proactividad'.toUpperCase(),
          image: (player.proactivity < 10)
              ? const MedalImage.redCoin()
              : (player.proactivity < 20)
                  ? const MedalImage.yellowCoin()
                  : const MedalImage.greenCoin(),
          numberColor: Colors2222.black,
          actionCallback: () =>
              Navigator.pushNamed(context, ScoreboardPlayersScreen.route),
          actionLabel: 'Tabla de Puntuaciones',
        ),
        const SizedBox(height: 25),
        AprobeAudioExplanation(),
        Divider(
          thickness: 2,
          height: 75,
          color: Colors2222.white.withOpacity(0.5),
        ),

        ObtainedMedalsCardWidget(
          numberOfMedals: player.contributionsAwards.length,
          label: 'Manifiesto -\nWiki'.toUpperCase(),
          image: const MedalImage.contribution(),
          numberColor: Colors2222.darkGrey,
        ),

        const SizedBox(height: 25),

        ObtainedMedalsCardWidget(
          numberOfMedals: player.clubhouseAwards.length,
          label: 'Eventos Clubhouse'.toUpperCase(),
          image: const MedalImage.clubhouse(),
          numberColor: Colors2222.darkGrey,
        ),
        const SizedBox(height: 25),

        ObtainedMedalsCardWidget(
          numberOfMedals: player.projectAwards.length,
          label: 'Proyecto \nPersonal'.toUpperCase(),
          image: const MedalImage.project(),
          numberColor: Colors2222.darkGrey,
        ),
        const SizedBox(height: 25),

        ObtainedMedalsCardWidget(
          numberOfMedals: player.marathonAwards.length,
          label: 'Maratón \nFinal'.toUpperCase(),
          image: const MedalImage.marathon(),
          numberColor: Colors2222.darkGrey,
        ),
      ],
    );
  }
}
