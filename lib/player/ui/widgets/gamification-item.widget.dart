import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/ui/screens/scoreboard.screen.dart';
import 'package:lab_movil_2222/player/ui/widgets/gammification-number.widget.dart';

import 'package:lab_movil_2222/themes/colors.dart';

class GamificationWidget extends StatefulWidget {
  final int numberOfMedals;
  final ImageProvider image;
  final String label;
  final Color numberColor;
  final bool? button;

  // ignore: sort_constructors_first
  const GamificationWidget({
    Key? key,
    required this.numberOfMedals,
    required this.image,
    required this.label,
    required this.numberColor,
    this.button,
  }) : super(key: key);

  @override
  _GamificationWidgetState createState() => _GamificationWidgetState();
}

class _GamificationWidgetState extends State<GamificationWidget> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).primaryTextTheme;
    final double sidePadding = MediaQuery.of(context).size.width * 0.1;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),

      /// content of card
      child: Column(
        children: [
          Row(
            children: [
              /// space items to the order
              Expanded(
                child: Text(
                  widget.label,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(color: Colors.grey.shade700),
                ),
              ),

              /// icon
              /// override image to fit a specified height
              Image(
                image: widget.image,
                fit: BoxFit.contain,
                height: 50,
                width: 50,
              ),

              /// space icon and number of medals
              const SizedBox(width: 8),

              /// number of medals
              GamificationNumber(
                number: widget.numberOfMedals,
                color: widget.numberColor,
              ),
            ],
          ),
          if (widget.button == true)
            Divider(
              thickness: 2,
              height: 25,
              color: Colors2222.black.withOpacity(0.5),
            ),
          if (widget.button == true)
            Material(
              type: MaterialType.transparency,
              color: Colors2222.black,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ScoreboardPlayersScreen.route);
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: Text(
                          'Tabla de Puntuaciones',
                          style: textTheme.button,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
