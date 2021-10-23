import 'dart:async';

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/current-player.service.dart';

import 'package:lab_movil_2222/player/ui/widgets/list-scoreboard.widget.dart';
import 'package:lab_movil_2222/services/load-players-scoreboard.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';

import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';

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
  StreamSubscription? _loadPlayerSub;

  ///
  List<PlayerModel>? teammates;
  PlayerModel? playerScore;

  LoadPlayerScoreboardService get _playersScoreBoard =>
      Provider.of<LoadPlayerScoreboardService>(context, listen: false);

  CurrentPlayerService get _currentPlayerService =>
      Provider.of<CurrentPlayerService>(context, listen: false);

  @override
  void initState() {
    super.initState();

    ///load list of players in order by proactivity
    _scoreboardSub = _playersScoreBoard.loadScoreboard$().listen((players) {
      setState(() {
        teammates = players;
      });
    });

    _loadPlayerSub = _currentPlayerService.player$.listen((player) {
      setState(() {
        playerScore = player;
      });
    });
  }

  @override
  void dispose() {
    _scoreboardSub?.cancel();
    _loadPlayerSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    ///TODO:change value to 10
    const int sizeScoreboard = 2;

    return Scaffold2222.empty(
      backgrounds: const [BackgroundDecorationStyle.bottomRight],
      appBar: AppBar(
        backgroundColor: Colors2222.red,
      ),
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

            for (var i = 0; i < sizeScoreboard; i++)
              ListScoreboardPlayers(
                  participant: teammates![i],
                  context: context,
                  numberProactivity: teammates![i].proactivity),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1,
                vertical: 15,
              ),
              child: Text(
                'El último de los 200',
                style:
                    textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            ListScoreboardPlayers(
              participant: teammates!.last,
              context: context,
              numberProactivity: teammates!.last.proactivity,
            ),
            if (playerScore == null)
              const AppLoading()
            else ...[
              ListScoreboardPlayers(
                  participant: playerScore!,
                  context: context,
                  numberProactivity: playerScore!.proactivity)
            ]
          ],
        ],
      ),
    );
  }
}
