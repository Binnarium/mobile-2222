import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/services/create-personal-chats.service.dart';
import 'package:lab_movil_2222/chat/services/get-chat.service.dart';
import 'package:lab_movil_2222/chat/services/list-general-chats.service.dart';
import 'package:lab_movil_2222/chat/ui/screens/chat-participants.screen.dart';
import 'package:lab_movil_2222/chat/ui/screens/messages.screen.dart';
import 'package:lab_movil_2222/chat/ui/widgets/chat-list-item.widget.dart';
import 'package:lab_movil_2222/chat/ui/widgets/chat-text-description.widget.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class GeneralChatsScreen extends StatefulWidget {
  const GeneralChatsScreen({Key? key}) : super(key: key);

  static const route = '/general_chats';

  @override
  _GeneralChatsScreenState createState() => _GeneralChatsScreenState();
}

class _GeneralChatsScreenState extends State<GeneralChatsScreen> {
  List<ChatModel>? allChats;

  /// list of chats founds
  List<PlayerModel>? foundPlayers;

  StreamSubscription? _createChatSub;
  StreamSubscription? _chatsSub;

  CreatePersonalChatService get _createPersonalChatService =>
      Provider.of<CreatePersonalChatService>(context, listen: false);

  GetChatService get _getChatService =>
      Provider.of<GetChatService>(context, listen: false);

  ListGeneralPlayerChatsService get _listPlayerChatsService =>
      Provider.of<ListGeneralPlayerChatsService>(context, listen: false);

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

    return Scaffold2222.empty(
      appBar: AppBar(
        backgroundColor: Colors2222.red,
      ),
      body: ListView(
        children: [
          

          /// page title
          Padding(
            padding: const EdgeInsets.only(bottom: 40,top: 50),
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

          /// if no chats loaded show loading icon
          if (allChats == null)
            const AppLoading()

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

}
