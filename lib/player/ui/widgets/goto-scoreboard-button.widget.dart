import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/ui/screens/scoreboard.screen.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class GotoScoreboardButton extends StatelessWidget {
  const GotoScoreboardButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).primaryTextTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors2222.white,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            primary: Colors2222.red,
          ),
          onPressed: () =>
              Navigator.pushNamed(context, ScoreboardPlayersScreen.route),
          child: Text(
            'Tabla de Puntuación',
            style: textTheme.button,
          ),
        ),
      ],
    );
  }
}
