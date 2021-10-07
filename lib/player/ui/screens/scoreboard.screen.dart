import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/services/load-players-scoreboard.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/user/widgets/widgets/list-scoreboard.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class ScoreboardPlayersScreen extends StatefulWidget {
  const ScoreboardPlayersScreen({
    Key? key,
  }) : super(key: key);

  static const route = '/score-board';

  @override
  _ScoreboardPlayersState createState() => _ScoreboardPlayersState();
}

class _ScoreboardPlayersState extends State<ScoreboardPlayersScreen> {
  ///
  StreamSubscription? _scoreboardSub;

  ///
  List<PlayerModel>? teammates;

  LoadPlayerScoreboardService get _playersScoreBoard =>
      Provider.of<LoadPlayerScoreboardService>(context, listen: false);

  @override
  void initState() {
    super.initState();

    ///load list of players in order by proactivity
    _scoreboardSub = _playersScoreBoard.loadScoreboard$().listen((players) {
      setState(() {
        teammates = players;
      });
    });
  }

  @override
  void dispose() {
    _scoreboardSub?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final double sidePadding = size.width * 0.08;

    return Scaffold2222.empty(
      backgrounds: const [BackgroundDecorationStyle.bottomRight],
      body: ListView(
        children: [
          /// title
          Container(
            constraints: BoxConstraints(
              maxWidth: min(size.width * 0.8, 300),
            ),
            padding: const EdgeInsets.only(bottom: 24, top: 60),
            alignment: Alignment.center,
            child: Text(
              'Tabla de Puntuacion'.toUpperCase(),
              style: textTheme.headline4,
              textAlign: TextAlign.center,
            ),
          ),

          ///If players no load
          if (teammates == null)
            const AppLoading()

          /// show a scoreboard list
          else ...[
            /// players items
            for (PlayerModel player in teammates!)
              ListScoreboardPlayers(
                participant: player,
                context: context,
                numberProactivity: player.proactivity,
              ),
          ],
        ],
      ),
    );
  }
}
