import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/services/create-personal-chats.service.dart';
import 'package:lab_movil_2222/chat/services/get-chat.service.dart';
import 'package:lab_movil_2222/chat/services/list-player-chats.service.dart';
import 'package:lab_movil_2222/chat/ui/screens/chat-participants.screen.dart';
import 'package:lab_movil_2222/chat/ui/screens/messages.screen.dart';
import 'package:lab_movil_2222/chat/ui/widgets/chat-list-item.widget.dart';
import 'package:lab_movil_2222/chat/ui/widgets/chat-text-description.widget.dart';
import 'package:lab_movil_2222/chat/ui/widgets/participants-list-item.widget.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/ui/widgets/search-player-input.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/bottom-navigation-bar-widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatefulWidget {
  static const route = '/chats';

  ChatsScreen({Key? key}) : super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<ChatModel>? allChats;

  /// list of chats founds
  List<PlayerModel>? foundPlayers;

  StreamSubscription? _createChatSub;
  StreamSubscription? _chatsSub;

  CreatePersonalChatService get _createPersonalChatService =>
      Provider.of<CreatePersonalChatService>(context, listen: false);

  GetChatService get _getChatService =>
      Provider.of<GetChatService>(context, listen: false);

  ListPlayerChatsService get _listPlayerChatsService =>
      Provider.of<ListPlayerChatsService>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _chatsSub = _listPlayerChatsService.chats$
        .listen((event) => setState(() => allChats = event));
  }

  @override
  void dispose() {
    _createChatSub?.cancel();
    _chatsSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final double sidePadding = size.width * 0.08;

    return Scaffold2222.navigation(
      activePage: Lab2222NavigationBarPages.chat,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: LogosHeader(
              showAppLogo: true,
            ),
          ),

          /// page title
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Center(
              child: Text(
                'CHAT DE VIAJEROS',
                style: textTheme.headline5,
              ),
            ),
          ),

          /// search input
          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 20),
            child: ChatTextDescription.informationText(
              color: Colors2222.white.withOpacity(0.8),
            ),
          ),

          /// search input
          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 20),
            child: SearchPlayersWidget(
              onValueChange: (text) {
                setState(() => foundPlayers = text);
              },
            ),
          ),

          /// searching results
          if (foundPlayers != null) ...[
            /// list of found chats
            for (PlayerModel player in foundPlayers!)
              ParticipantsListItem(
                context: context,
                color: Colors2222.white,
                primaryColor: Colors2222.white,
                participant: ChatParticipantModel(
                    displayName: player.displayName, uid: player.uid),
                createChatCallback: _createChatSub == null
                    ? (context) =>

                        /// TODO: fix this
                        _createChat(FirebaseAuth.instance.currentUser!.uid)
                    : null,
              ),
          ]

          /// if no chats loaded show loading icon
          else if (allChats == null)
            AppLoading()

          /// show a list of all chats
          else ...[
            /// chats items
            for (ChatModel chat in allChats!)
              ChatListItem(chat: chat, context: context),
          ],
        ],
      ),
    );
  }

  /// TODO: remove duplicated code
  void _createChat(String playerId) {
    if (_createChatSub != null) return;

    setState(() {
      _createChatSub = _createPersonalChatService.create$(playerId).listen(
        (response) async {
          /// validate chat was found
          if (response.chatId == null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(ChatSnackbar.couldNotCreateChat());
            return;
          }

          /// load chat
          final ChatModel? chat =
              await _getChatService.getChatWithId(response.chatId!);
          if (chat == null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(ChatSnackbar.chatNotFound());
            return;
          }

          Navigator.pushNamed(context, MessagesScreen.route,
              arguments: MessagesScreen(chat: chat));
        },

        /// clean stream
        onDone: () {
          setState(() {
            _createChatSub?.cancel();
            _createChatSub = null;
          });
        },
      );
    });
  }
}
