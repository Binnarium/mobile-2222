import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/chat/ui/widgets/participants-list-medals.widget.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/ui/widgets/search-player-input.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
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

class MedalsHackatonScreen extends StatefulWidget {
  static const route = '/medals-hackaton';

  final CityDto city;

  const MedalsHackatonScreen({Key? key, required this.city}) : super(key: key);

  @override
  _MedalsHackatonScreenState createState() => _MedalsHackatonScreenState();
}

class _MedalsHackatonScreenState extends State<MedalsHackatonScreen> {
  StreamSubscription? _createChatSub;
  List<PlayerModel>? foundPlayers;

  @override
  void dispose() {
    this._createChatSub?.cancel();
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
      route: MedalsHackatonScreen.route,
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
                "Hackaton de Proyectos",
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

          /// search input
          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 32),
            child: Markdown2222(
              data: explanationText,
            ),
          ),

          /// search input
          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 20),
            child: SearchPlayersWidget(
              color: this.widget.city.color,
              onValueChange: (text) {
                this.setState(() => foundPlayers = text);
              },
            ),
          ),

          /// searching results
          if (this.foundPlayers != null) ...[
            /// list of found chats
            for (PlayerModel player in this.foundPlayers!)
              ParticipantsListMedalsItem(
                  context: context,
                  color: Colors2222.white,
                  primaryColor: Colors2222.white,
                  participant: ChatParticipantModel(
                      displayName: player.displayName, uid: player.uid),
                  createChatCallback: null),
          ],
        ],
      ),
    );
  }
}
