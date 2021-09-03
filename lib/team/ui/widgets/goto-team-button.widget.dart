import 'package:flutter/material.dart';
import 'package:lab_movil_2222/team/ui/screens/team.screen.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class GotoTeamButton extends StatelessWidget {
  const GotoTeamButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).primaryTextTheme;
    return Row(
      children: [
        TextButton(
          child: Text(
            'Equipo 2222',
            style: textTheme.button,
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors2222.white,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            primary: Colors2222.red,
          ),
          onPressed: () => Navigator.pushNamed(context, TeamScreen.route),
        ),
      ],
    );
  }
}
