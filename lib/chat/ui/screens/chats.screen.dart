import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/services/list-general-chats.service.dart';
import 'package:lab_movil_2222/chat/services/list-group-chats.service.dart';
import 'package:lab_movil_2222/chat/ui/widgets/chat-list-item.widget.dart';
import 'package:lab_movil_2222/chat/ui/widgets/chat-text-description.widget.dart';
import 'package:lab_movil_2222/chat/ui/widgets/folder-chat.widget.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/bottom-navigation-bar-widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  static const route = '/chats';

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<ChatModel>? generalChats;
  List<ChatModel>? groupChats;

  /// list of chats founds
  List<PlayerModel>? foundPlayers;

  StreamSubscription? _createChatSub;
  StreamSubscription? _generalchatsSub;
  StreamSubscription? _groupchatsSub;

  ListGeneralPlayerChatsService get _listGeneralChatsService =>
      Provider.of<ListGeneralPlayerChatsService>(context, listen: false);
  ListGroupPlayerChatsService get _listGroupChatsService =>
      Provider.of<ListGroupPlayerChatsService>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _generalchatsSub = _listGeneralChatsService.chats$
        .listen((event) => setState(() => generalChats = event));
    _groupchatsSub = _listGroupChatsService.chats$
        .listen((event) => setState(() => groupChats = event));
  }

  @override
  void dispose() {
    _createChatSub?.cancel();
    _generalchatsSub?.cancel();
    _groupchatsSub?.cancel();
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
          const Padding(
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

          /// description text
          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 20),
            child: ChatTextDescription.informationText(
              color: Colors2222.white.withOpacity(0.8),
            ),
          ),
          if (generalChats == null)
            const AppLoading()

          /// show a list of all chats
          else ...[
            /// chats items
            for (ChatModel chat in generalChats!)
              ChatListItem(chat: chat, context: context),
          ],
          if (groupChats == null)
            const AppLoading()

          /// show a list of all chats
          else ...[
            /// chats items
            for (ChatModel chat in groupChats!)
              ChatListItem(chat: chat, context: context),
          ],

          const ListFolderChat(route: 'Personal'),
        ],
      ),
    );
  }
}
