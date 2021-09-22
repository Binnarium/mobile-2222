import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/project/services/upload-maraton-medal.service.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/list-players-of-group.service.dart';
import 'package:lab_movil_2222/player/ui/widgets/participants-list-medals.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
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
  StreamSubscription? _groupSub;
  StreamSubscription? _awardedSub;

  ///
  StreamSubscription? _medalSub;

  ///
  List<PlayerModel>? allPlayers;
  String? awardedPlayerUID;

  ///
  List<PlayerModel>? foundPlayers;

  ListPlayerOfGroupService get _playersGroupService =>
      Provider.of<ListPlayerOfGroupService>(context, listen: false);

  UploadMaratonMedalService get _createMaratonMedalService =>
      Provider.of<UploadMaratonMedalService>(this.context, listen: false);
  @override
  void initState() {
    super.initState();
    _groupSub = _playersGroupService.group$.listen(
      (players) => setState(() => allPlayers = players),
    );
    // _createMaratonMedalService.loadAwardedUID('s').then((value) => awardedPlayerUID=value);
        
  }

  @override
  void dispose() {
    _groupSub?.cancel();
    _awardedSub?.cancel();
    _medalSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final double sidePadding = size.width * 0.08;

    return Scaffold2222.city(
      city: widget.city,
      // ignore: prefer_const_literals_to_create_immutables
      backgrounds: [BackgroundDecorationStyle.bottomRight],
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
                image: const CoinsImages.hackaton(),
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

          ///If players no load
          if (allPlayers==null)
            const AppLoading()

          /// show a list of all players of group
          else ...[
            /// chats items
            for (PlayerModel player in this.allPlayers!)
              ParticipantsListMedalsItem(
                participant: player,
                context: context,
                createChatCallback: _medalSub == null
                    ? (context) => _createMedal(player.uid)
                    : null,
              ),
          ],
        ],
      ),
    );
  }

  void _createMedal(String playerId) {
    bool isSend;
    if (this._medalSub != null) return;

    setState(() {
      _medalSub = _createMaratonMedalService.medal$(playerId).listen(
        (response) async {
          /// validate chat was found
        },

        /// clean stream
        onDone: () {
          setState(() {
            _medalSub?.cancel();
            _medalSub = null;
          });
        },
      );
    });
  }
}
