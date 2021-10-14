import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/audio/ui/audio-player.widget.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/ui/widgets/gamification-item.widget.dart';
import 'package:lab_movil_2222/points-explanation/models/points-explanation.model.dart';
import 'package:lab_movil_2222/themes/colors.dart';

/// widget that contains a list of the player's gamification
/// - [player] is required to avoid the use of the user stream service
class 
PlayerGamification extends StatelessWidget {
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
          label: 'Nivel de Proactivi dad'.toUpperCase(),
          image: (numberProactivity < 10)
              ? const MedalImage.redCoin()
              : (numberProactivity < 20)
                  ? const MedalImage.yellowCoin()
                  : const MedalImage.greenCoin(),
          numberColor: Colors2222.black,
          button: true,
        ),

        /// audio
        if (pointsExplanation?.audio != null)
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
          image: const MedalImage.contribution(),
          numberColor: Colors2222.darkGrey,
        ),

        const SizedBox(height: 25),

        GamificationWidget(
          numberOfMedals: player.clubhouseAwards.length,
          label: 'Eventos Clubhouse'.toUpperCase(),
          image: const MedalImage.clubhouse(),
          numberColor: Colors2222.darkGrey,
        ),
        const SizedBox(height: 25),

        GamificationWidget(
          numberOfMedals: player.projectAwards.length,
          label: 'Proyecto \nPersonal'.toUpperCase(),
          image: const MedalImage.project(),
          numberColor: Colors2222.darkGrey,
        ),
        const SizedBox(height: 25),

        GamificationWidget(
          numberOfMedals: player.maratonAwards.length,
          label: 'Maratón \nFinal'.toUpperCase(),
          image: const MedalImage.marathon(),
          numberColor: Colors2222.darkGrey,
        ),
      ],
    );
  }
}
