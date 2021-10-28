import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/current-player.service.dart';
import 'package:lab_movil_2222/player/services/load-players-scoreboard.service.dart';
import 'package:lab_movil_2222/player/ui/widgets/list-scoreboard.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/header-logos.widget.dart';
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
    _scoreboardSub = _playersScoreBoard.loadScoreboard$.listen((players) {
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

    return Scaffold2222.navigation(
      activePage: null,
      backgrounds: const [
        BackgroundDecorationStyle.bottomRight,
        BackgroundDecorationStyle.topLeft,
      ],
      body: ListView(
        children: [
          /// app logo
          const Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: LogosHeader(
              showAppLogo: true,
            ),
          ),

          /// title
          Container(
            constraints: BoxConstraints(
              maxWidth: min(size.width * 0.8, 300),
            ),
            alignment: Alignment.center,
            child: Text(
              'Tabla de Puntuación'.toUpperCase(),
              style: textTheme.headline4,
              textAlign: TextAlign.center,
            ),
          ),

          /// spacer
          const SizedBox(height: 20),

          ///If players no load
          if (teammates == null)
            const AppLoading()

          /// show a scoreboard list
          else ...[
            /// players items

            for (var i = 0; i < teammates!.length; i++)
              ListScoreboardPlayers(
                participant: teammates![i],
                context: context,
                numberProactivity: teammates![i].proactivity,
              ),
          ],
        ],
      ),
    );
  }
}
