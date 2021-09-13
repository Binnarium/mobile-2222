import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/chat/services/create-personal-chats.service.dart';
import 'package:lab_movil_2222/chat/services/get-chat.service.dart';
import 'package:lab_movil_2222/chat/ui/widgets/participants-list-medals.widget.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/ui/widgets/search-player-input.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

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
  CreatePersonalChatService get _createPersonalChatService =>
      Provider.of<CreatePersonalChatService>(this.context, listen: false);

  GetChatService get _getChatService =>
      Provider.of<GetChatService>(this.context, listen: false);

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
        body: ListView(children: [
          /// chat name

          ///
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: Text(
                'hackaton'.toUpperCase(),
                style: textTheme.headline5!.copyWith(
                  color: Colors2222.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          /// search input
          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 20, sidePadding, 20),
            child: SearchPlayersWidget(
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
        ]));
  }

  void _createChat(String playerId) {}
}
