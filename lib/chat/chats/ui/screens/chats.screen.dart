import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/chats/models/chat-folder.model.dart';
import 'package:lab_movil_2222/chat/chats/services/list-chats-folders.service.dart';
import 'package:lab_movil_2222/chat/chats/ui/widgets/chat-folder-list-item.widget.dart';
import 'package:lab_movil_2222/chat/ui/widgets/chat-text-description.widget.dart';
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
  List<ChatFolderModel>? chatFolders;

  StreamSubscription? _loadChatFolders;

  ListChatsFoldersService get _chatFolders =>
      Provider.of<ListChatsFoldersService>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _loadChatFolders = _chatFolders.folders$
        .listen((folders) => setState(() => chatFolders = folders));
  }

  @override
  void dispose() {
    _loadChatFolders?.cancel();
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
          if (chatFolders == null)
            const AppLoading()

          /// show a list of all chats
          else ...[
            /// chats items
            for (ChatFolderModel folder in chatFolders!)
              ChatFolderListItem(folder: folder, context: context),
          ],
        ],
      ),
    );
  }
}
