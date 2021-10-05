import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';

class GameOverScreen extends StatefulWidget {
  const GameOverScreen({
    Key? key,
    required CityModel city,
  })  : city = city,
        super(key: key);

  static const String route = '/game-over-screen';
  final CityModel city;

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold2222.city(
        body: const Center(
          child: Text('GAME OVER screen'),
        ),
        city: widget.city,
        route: GameOverScreen.route);
  }
}
