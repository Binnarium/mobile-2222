import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/ui/widgets/participants-list-medals.widget.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/chat/ui/widgets/participants-list-medals.widget.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/list-player-group.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

final String explanationText = """
Llegó el momento de darle un premio al docente viajero de tu grupo de 10 colegas que consideras haya hecho el proyecto personal más innovador y mejor desarrollado de todos.

1. Elige al viajero que consideras haya tenido mejor desempeño en su proyecto.
2. Otórgale el premio a esa persona.
3. Ese premio se visualizará en la página personal del viajero.
""";


class MedalsMaratonScreen extends StatefulWidget {
  static const route = '/medals-maraton';


  final Stream<List<PlayerModel>> playerGroup;
  final CityModel city;

  MedalsMaratonScreen({Key? key, required this.city})
      : this.playerGroup = ListPlayerGroupService.instance.players$,
        super(key: key);

  @override
  _MedalsMaratonScreenState createState() => _MedalsMaratonScreenState();
}

class _MedalsMaratonScreenState extends State<MedalsMaratonScreen> {
  List<PlayerModel>? foundPlayers;

  StreamSubscription? _groupSub;

  List<PlayerModel>? allPlayers;

  @override
  void initState() {
    super.initState();
    _groupSub = this
        .widget
        .playerGroup
        .listen((event) => this.setState(() => this.allPlayers = event));
  }

  @override
  void dispose() {
    this._groupSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final double sidePadding = size.width * 0.08;

    return Scaffold2222.city(
      city: this.widget.city,
      backgrounds: [BackgroundDecorationStyle.bottomRight],
      route: MedalsMaratonScreen.route,
      body: ListView(
        children: [
          /// icon item
          Padding(
            padding: EdgeInsets.only(
              bottom: 32.0,
            ),
            child: LogosHeader(
              showStageLogoCity: this.widget.city,
            ),
          ),

          ///
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Center(
              child: Text(

                "Premiación de Proyectos",

                style: textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 32),
            child: Center(
              child: Image(
                image: CoinsImages.hackaton(),
                alignment: Alignment.bottomRight,
                fit: BoxFit.contain,
                width: min(160, size.width * 0.4),
              ),
            ),
          ),

          /// explanation
          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 32),
            child: Markdown2222(
              data: explanationText,
            ),
          ),

          ///If players no load
          if (this.allPlayers == null)
            AppLoading()

          /// show a list of all players of group
          else ...[
            /// chats items
            for (PlayerModel player in this.allPlayers!)
              ParticipantsListMedalsItem(participant: player, context: context),
          ],
        ],
      ),
    );
  }
}
