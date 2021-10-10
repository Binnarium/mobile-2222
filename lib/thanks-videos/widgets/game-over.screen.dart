import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
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
    const String data =
        """ **__"Trabaja en tu obra hasta que la gente no sea capaz de imaginar que lo que has diseñado exista de ninguna otra forma. La belleza es la obra bien resuelta, es simple."__** - Alan Moore.

**¡Gracias viajeros 2222!**

 """;
    return Scaffold2222.city(
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Markdown2222(
              data: data,
            ),
          ),
        ),
        city: widget.city,
        route: GameOverScreen.route);
  }
}
