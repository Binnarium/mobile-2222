import 'package:flutter/material.dart';

class MedalImage extends AssetImage {
  const MedalImage.redCoin()
      : super('assets/gamification/2222_proactivo_rojo.png');

  const MedalImage.yellowCoin()
      : super('assets/gamification/2222_proactivo_amarillo.png');

  const MedalImage.greenCoin()
      : super('assets/gamification/2222_proactivo_verde.png');

  const MedalImage.project() : super('assets/gamification/2222_project.png');

  const MedalImage.marathon() : super('assets/gamification/2222_marathon.png');

  const MedalImage.marathonGrey()
      : super('assets/gamification/2222_marathon_gray.png');

  const MedalImage.clubhouse()
      : super('assets/gamification/2222_medalla-clubhouse.png');

  const MedalImage.contribution()
      : super('assets/gamification/2222_monedas.png');
}
