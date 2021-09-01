import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/search-chat-response.model.dart';
import 'package:lab_movil_2222/chat/services/list-player-chats.service.dart';
import 'package:lab_movil_2222/chat/services/search-chats.service.dart';
import 'package:lab_movil_2222/chat/ui/widgets/chat-list-item.widget.dart';
import 'package:lab_movil_2222/chat/ui/widgets/chat-list-title.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/form/text-form-field-2222.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/bottom-navigation-bar-widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

class ChatsScreen extends StatefulWidget {
  static const route = "/chats";

  final Stream<List<ChatModel>> userChats;

  ChatsScreen({Key? key})
      : this.userChats = ListPlayerChatsService().getChats,
        super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final SearchChatsService _searchChatsService = SearchChatsService();
  StreamSubscription? _chatsSub;

  List<ChatModel>? allChats;

  final TextEditingController _searchController = TextEditingController();

  /// list of chats founds
  List<ChatModel?>? searchResults;

  @override
  void initState() {
    super.initState();
    _chatsSub = this
        .widget
        .userChats
        .listen((event) => this.setState(() => this.allChats = event));
  }

  @override
  void dispose() {
    this._chatsSub?.cancel();
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
                'EL CHAT DE 2222',
                style: textTheme.headline5,
              ),
            ),
          ),

          /// search input
          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 20),
            child: TextFormField222(
              controller: this._searchController,
              label: 'Buscar Chat',
              prefixIcon: Icons.search,
              onValueChanged: (value) async {
                if (value!.isEmpty) {
                  this.setState(() {
                    this.searchResults = null;
                  });
                  return;
                }

                List<SearchChatResponseModel>? searchChatsResults =
                    await this._searchChatsService.search(value);

                this.setState(() {
                  this.searchResults = searchChatsResults
                      ?.map((searchResult) => this
                          .allChats
                          ?.firstWhere((chat) => chat.id == searchResult.id))
                      .toList();
                });
              },
            ),
          ),

          /// searching results
          if (this.searchResults != null) ...[
            /// found results title
            ChatListTitle(title: 'Resultados de búsqueda', context: context),

            /// list of found chats
            for (ChatModel? chat in this.searchResults!)
              if (chat != null)
                ChatListItem(
                  chat: chat,
                  context: context,
                ),
          ],

          /// if no chats loaded show loading icon
          if (this.allChats == null)
            AppLoading()

          /// show a list of all chats
          else ...[
            /// all chats title
            ChatListTitle(title: 'Todas las conversaciones', context: context),

            /// chats items
            for (ChatModel chat in this.allChats!)
              ChatListItem(chat: chat, context: context),
          ],
        ],
      ),
    );
  }
}
