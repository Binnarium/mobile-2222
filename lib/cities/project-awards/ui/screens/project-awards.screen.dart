import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/project-awards/models/marathon-medal.model.dart';
import 'package:lab_movil_2222/cities/project-awards/services/medals.service.dart';
import 'package:lab_movil_2222/home-map/models/city.dto.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/current-player.service.dart';
import 'package:lab_movil_2222/player/services/list-players-of-group.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:lab_movil_2222/workshop-medals/ui/participants-list-medals.widget.dart';
import 'package:provider/provider.dart';

const String explanationText = '''
Llegó el momento de darle un premio al docente viajero de tu grupo de 10 colegas que consideras haya hecho el proyecto personal más innovador y mejor desarrollado de todos.

1. Elige al viajero que consideras haya tenido mejor desempeño en su proyecto.
2. Otórgale el premio a esa persona.
3. Ese premio se visualizará en la página personal del viajero.
''';

class ProjectAwardsProject extends StatefulWidget {
  const ProjectAwardsProject({
    Key? key,
    required this.city,
  }) : super(key: key);

  static const route = '/medals-maraton';

  final CityModel city;

  @override
  _ProjectAwardsProjectState createState() => _ProjectAwardsProjectState();
}

class _ProjectAwardsProjectState extends State<ProjectAwardsProject> {
  ///
  StreamSubscription? _teammatesSub;

  ///
  StreamSubscription? _medalsAwardedSub;

  ///
  StreamSubscription? _assignAwardSub;
  StreamSubscription? _canAssignAwardSub;
  StreamSubscription? _currentPlayerSub;

  ///
  List<PlayerModel>? marathonGroupMembers;

  List<MarathonMedalModel> awardedMedals = [];

  bool canAssignMarathonAwards = true;
  PlayerModel? currentPlayer;

  ListPlayerOfGroupService get _playersGroupService =>
      Provider.of<ListPlayerOfGroupService>(context, listen: false);

  MedalsService get _medalsService =>
      Provider.of<MedalsService>(context, listen: false);

  CurrentPlayerService get _currentPlayerService =>
      Provider.of<CurrentPlayerService>(context, listen: false);

  @override
  void initState() {
    super.initState();

    _currentPlayerSub = _currentPlayerService.player$.listen(
      (player) => setState(() => currentPlayer = player),
    );

    _teammatesSub = _playersGroupService.group$.listen(
      (players) => setState(() => marathonGroupMembers = players),
    );

    _medalsAwardedSub = _medalsService.marathonAwards$.listen(
      (awards) => setState(() => awardedMedals = awards),
    );

    _canAssignAwardSub = _medalsService.canAssignMarathonAwards$.listen(
      (canAssign) => setState(() => canAssignMarathonAwards = canAssign),
    );
  }

  @override
  void dispose() {
    _currentPlayerSub?.cancel();
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

    return Scaffold2222.city(
      city: widget.city,
      backgrounds: const [BackgroundDecorationStyle.bottomRight],
      route: ProjectAwardsProject.route,
      body: ListView(
        children: [
          /// icon item
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: LogosHeader(showStageLogoCity: widget.city),
          ),

          /// title
          Container(
            constraints: BoxConstraints(
              maxWidth: min(size.width * 0.8, 300),
            ),
            padding: const EdgeInsets.only(bottom: 24),
            alignment: Alignment.center,
            child: Text(
              'Premiación de Proyectos'.toUpperCase(),
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

          /// explanation
          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 32),
            child: const Markdown2222(
              data: explanationText,
            ),
          ),

          /// message that group is not assigned yet
          if (currentPlayer?.marathonGroupId == null)
            Padding(
              padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 32),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors2222.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding:
                    EdgeInsets.symmetric(horizontal: sidePadding, vertical: 10),
                child: const Markdown2222(
                    textColor: Colors2222.black,
                    data:
                        'Para participar de esta actividad ingresa a la actividad Maratón de Proyectos y espera a que se te asigne un grupo'),
              ),
            )
          else

          ///If players no load
          if (marathonGroupMembers == null)
            const AppLoading()

          /// show a list of all players of group
          else ...[
            /// chats items
            for (PlayerModel player in marathonGroupMembers!)
              AssignMedalListItem(
                participant: player,
                context: context,
                isAssigned: awardedMedals
                    .any((award) => award.awardedToUid == player.uid),
                canAssign: canAssignMarathonAwards,
                callback: () => _createMedal(player.uid),
              ),
          ],
        ],
      ),
    );
  }

  void _createMedal(String playerId) {
    if (_assignAwardSub != null) {
      return;
    }

    _assignAwardSub = _medalsService
        .assignMedal$(cityId: widget.city.id, teammateUid: playerId)
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
