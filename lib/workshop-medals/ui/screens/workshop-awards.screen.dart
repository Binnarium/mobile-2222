import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/list-players-of-group.service.dart';
import 'package:lab_movil_2222/player/ui/widgets/search-player-input.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:lab_movil_2222/workshop-medals/models/workshop-medal.model.dart';
import 'package:lab_movil_2222/workshop-medals/services/workshop-medals.service.dart';
import 'package:lab_movil_2222/workshop-medals/ui/current-player-workshop-awards.widgets.dart';
import 'package:lab_movil_2222/workshop-medals/ui/participants-list-medals.widget.dart';
import 'package:provider/provider.dart';

const String explanationText = '''
Al finalizar el Taller de Ideación Ágil de 10 horas de duración, cada uno de los viajeros participantes podrá otorgar una medalla de premio a quién estime mejor, dentro de los propios participantes. Esta premiación resultará fundamental para la selección de los 20 viajeros finalistas para la etapa de mentorías con PRENDHO UTPL. La selección saldrá de una combinación entre los mejores desempeños del viaje inicial de 35 días + la elección del coordinador y mentor del Taller de 10 horas + la premiación colaborativa resultante del propio Taller.

1. Elige al viajero que consideras haya tenido mejor desempeño con su proyecto de innovación personal docente durante el taller.

2. Otórgale el premio a esa persona.

3. Ese premio se verá reflejado en la pagina personal del viajero.
''';

class WorkshopAwardsScreen extends StatefulWidget {
  const WorkshopAwardsScreen({
    Key? key,
  }) : super(key: key);

  static const route = '/workshop-medals-screen';

  @override
  _WorkshopAwardsScreenState createState() => _WorkshopAwardsScreenState();
}

class _WorkshopAwardsScreenState extends State<WorkshopAwardsScreen> {
  ///
  StreamSubscription? _teammatesSub;

  ///
  StreamSubscription? _medalsAwardedSub;

  ///
  StreamSubscription? _assignAwardSub;
  StreamSubscription? _canAssignAwardSub;

  ///
  List<PlayerModel>? teammates;
  List<PlayerModel>? searchPlayers;

  List<PlayerModel>? get resultPlayers => searchPlayers == null
      ? teammates
      : searchPlayers!
          .where((player) =>
              teammates?.any((search) => search.uid == player.uid) == true)
          .toList();

  List<WorkshopMedalModel> awardedMedals = [];

  bool canAssignMarathonAwards = true;

  ListPlayerOfGroupService get _playersGroupService =>
      Provider.of<ListPlayerOfGroupService>(context, listen: false);

  WorkshopMedalsService get _workshopMedalsService =>
      Provider.of<WorkshopMedalsService>(context, listen: false);

  @override
  void initState() {
    super.initState();

    _teammatesSub = _playersGroupService.workshop$.listen(
      (players) => setState(() => teammates = players),
    );

    _medalsAwardedSub = _workshopMedalsService.workshopAwards$.listen(
      (awards) => setState(() => awardedMedals = awards),
    );

    _canAssignAwardSub = _workshopMedalsService.canAssignWorkshopAwards$.listen(
      (canAssign) => setState(() => canAssignMarathonAwards = canAssign),
    );
  }

  @override
  void dispose() {
    _teammatesSub?.cancel();
    _assignAwardSub?.cancel();
    _medalsAwardedSub?.cancel();
    _canAssignAwardSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final double sidePadding = size.width * 0.08;

    return Scaffold2222.navigation(
      activePage: null,
      backgrounds: const [BackgroundDecorationStyle.bottomRight],
      body: ListView(
        children: [
          /// icon item
          const Padding(
            padding: EdgeInsets.only(bottom: 32.0),
            child: LogosHeader(showAppLogo: true),
          ),

          /// title
          Container(
            constraints: BoxConstraints(
              maxWidth: min(size.width * 0.8, 300),
            ),
            padding: EdgeInsets.only(
                bottom: 24, left: sidePadding, right: sidePadding),
            alignment: Alignment.center,
            child: Text(
              'PREMIACIÓN\nTaller de Ideación Ágil',
              style: textTheme.headline4,
              textAlign: TextAlign.center,
            ),
          ),

          /// medal
          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 32),
            child: Center(
              child: Image(
                image: const MedalImage.marathon(),
                alignment: Alignment.bottomRight,
                fit: BoxFit.contain,
                width: min(160, size.width * 0.4),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 32),
            child: CurrentPlayerWorkshopAwards(),
          ),

          /// explanation
          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 32),
            child: const Markdown2222(
              data: explanationText,
            ),
          ),

          ///If players no load
          if (resultPlayers == null)
            const AppLoading()

          /// show a list of all players of group
          else ...[
            /// search input
            Padding(
              padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 20),
              child: SearchPlayersWidget(
                onValueChange: (players) {
                  setState(() => searchPlayers = players);
                },
              ),
            ),

            /// chats items
            for (PlayerModel player in resultPlayers!)
              AssignMedalListItem(
                participant: player,
                context: context,
                isAssigned: awardedMedals
                    .any((award) => award.awardedToUid == player.uid),
                canAssign: canAssignMarathonAwards,
                callback: () => _createMedal(player.uid),
              ),
          ],
          const SizedBox.square(dimension: 40),
        ],
      ),
    );
  }

  void _createMedal(String playerId) {
    if (_assignAwardSub != null) {
      return;
    }

    _assignAwardSub = _workshopMedalsService
        .assignMedal$(cityId: 'TODO:', teammateUid: playerId)
        .listen(
      (success) async {
        final SnackBar message = success
            ? const SnackBar(
                content: Text(
                  'Has asignado la medalla a tu compañero',
                ),
              )
            : const SnackBar(
                content: Text(
                  'Ocurrio un problema al asignar la medalla',
                ),
              );

        /// show message
        ScaffoldMessenger.of(context).showSnackBar(message);
      },

      /// clean stream
      onDone: () {
        _assignAwardSub?.cancel();
        _assignAwardSub = null;
      },
    );
  }
}
