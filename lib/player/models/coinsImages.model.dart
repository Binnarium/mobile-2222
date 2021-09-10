import 'package:flutter/material.dart';

class CoinsImages extends Image {
  CoinsImages.redCoin({Key? key})
      : super(
          image: AssetImage('assets/gamification/2222_proactivo_rojo.png'),
          fit: BoxFit.contain,
          height: 50,
        );

  CoinsImages.yellowCoin({Key? key})
      : super(
          image: AssetImage('assets/gamification/2222_proactivo_amarillo.png'),
          fit: BoxFit.contain,
          height: 50,
        );
  CoinsImages.greenCoin({Key? key})
      : super(
          image: AssetImage('assets/gamification/2222_proactivo_verde.png'),
          fit: BoxFit.contain,
          height: 50,
        );
}
