import 'package:flutter/material.dart';

class CoinsImages extends AssetImage {
  CoinsImages.redCoin({Key? key})
      : super('assets/gamification/2222_proactivo_rojo.png');

  CoinsImages.yellowCoin({Key? key})
      : super('assets/gamification/2222_proactivo_amarillo.png');

  CoinsImages.greenCoin({Key? key})
      : super('assets/gamification/2222_proactivo_verde.png');

  CoinsImages.project({Key? key})
      : super('assets/gamification/2222_monedas.png');
  CoinsImages.hackaton({Key? key})
      : super('assets/gamification/2222_monedas.png');

  CoinsImages.clubhouse({Key? key})
      : super('assets/gamification/2222_medalla-clubhouse.png');

  CoinsImages.contribution({Key? key})
      : super('assets/gamification/2222_monedas.png');
}
