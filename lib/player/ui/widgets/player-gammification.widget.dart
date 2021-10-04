import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/audio/ui/audio-player.widget.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/ui/widgets/gamification-item.widget.dart';
import 'package:lab_movil_2222/points-explanation/models/points-explanation.model.dart';
import 'package:lab_movil_2222/themes/colors.dart';

/// widget that contains a list of the player's gamification
/// - [player] is required to avoid the use of the user stream service
class PlayerGamification extends StatelessWidget {
  const PlayerGamification({
    Key? key,
    required this.player,
    required this.pointsExplanation,
  }) : super(key: key);

  final PlayerModel player;
  final PointsExplanationModel? pointsExplanation;

  @override
  Widget build(BuildContext context) {
    final int numberProactivity = player.clubhouseAwards.length +
        player.projectAwards.length +
        player.contributionsAwards.length;

    return Column(
      children: [
        /// player's gammification
        GamificationWidget(
          numberOfMedals: numberProactivity,
          label: 'Nivel de Proactividad'.toUpperCase(),
          image: (numberProactivity < 10)
              ? const CoinsImages.redCoin()
              : (numberProactivity < 20)
                  ? const CoinsImages.yellowCoin()
                  : const CoinsImages.greenCoin(),
          numberColor: Colors2222.black,
        ),

        /// audio
        if (pointsExplanation!.audio != null)
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: AudioPlayerWidget(audio: pointsExplanation!.audio!),
          ),

        Divider(
          thickness: 2,
          height: 75,
          color: Colors2222.white.withOpacity(0.5),
        ),

        GamificationWidget(
          numberOfMedals: player.contributionsAwards.length,
          label: 'Manifiesto -\nWiki'.toUpperCase(),
          image: const CoinsImages.contribution(),
          numberColor: Colors2222.darkGrey,
        ),

        const SizedBox(height: 25),

        GamificationWidget(
          numberOfMedals: player.clubhouseAwards.length,
          label: 'Eventos Clubhouse'.toUpperCase(),
          image: const CoinsImages.clubhouse(),
          numberColor: Colors2222.darkGrey,
        ),
        const SizedBox(height: 25),

        GamificationWidget(
          numberOfMedals: player.projectAwards.length,
          label: 'Proyecto \nPersonal'.toUpperCase(),
          image: const CoinsImages.project(),
          numberColor: Colors2222.darkGrey,
        ),
        const SizedBox(height: 25),

        GamificationWidget(
          numberOfMedals: player.maratonAwards.length,
          label: 'Maratón \nFinal'.toUpperCase(),
          image: const CoinsImages.hackaton(),
          numberColor: Colors2222.darkGrey,
        ),
      ],
    );
  }
}
