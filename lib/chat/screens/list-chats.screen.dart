import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/search-chat-query.model%20copy.dart';
import 'package:lab_movil_2222/chat/models/search-chat-response.model.dart';
import 'package:lab_movil_2222/chat/screens/chat.screen.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/form/text-form-field-2222.widget.dart';

class ListChatsScreen extends StatefulWidget {
  static const route = "/list-chats";

  final Stream<List<ChatModel>> userChats;

  ListChatsScreen({Key? key})
      : this.userChats = FirebaseFirestore.instance
            .collection('chats')
            .snapshots()
            .map((event) =>
                event.docs.map((e) => ChatModel.fromMap(e.data())).toList()),
        super(key: key);

  @override
  _ListChatsScreenState createState() => _ListChatsScreenState();
}

class _ListChatsScreenState extends State<ListChatsScreen> {
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

    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
        activePage: NavigationBarPages.chat,
      ),
      backgroundColor: Colors2222.primary,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: ChapterHeadWidget(
              showAppLogo: true,
            ),
          ),

          /// page title
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Center(
              child: Text('EL CHAT DE 2222', style: textTheme.headline5),
            ),
          ),

          /// search input
          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 20),
            child: TextFormField222(
              controller: this._searchController,
              label: 'Buscar Chat',
              onValueChanged: (value) async {
                if (value!.isEmpty) {
                  this.setState(() {
                    this.searchResults = null;
                  });
                  return;
                }
                HttpsCallable searchPlayers =
                    FirebaseFunctions.instance.httpsCallable('searchChat');
                final SearchChatQueryModel query = SearchChatQueryModel(
                  playerId: FirebaseAuth.instance.currentUser!.uid,
                  query: value,
                );
                final results = await searchPlayers<String>(query.toMap());
                final List<Map<String, dynamic>>? data =
                    (jsonDecode(results.data) as List<dynamic>)
                        .map((e) => e as Map<String, dynamic>)
                        .toList();

                print(data);
                List<SearchChatResponseModel>? searchChatsResults = data
                    ?.map((e) => SearchChatResponseModel.fromMap(e))
                    .toList();

                this.setState(() {
                  this.searchResults = searchChatsResults
                      ?.map((searchResult) => this
                          .allChats
                          ?.firstWhere((chat) => chat.id == searchResult.id))
                      .toList();
                });
              },
              prefixIcon: Icons.search,
            ),
          ),

          /// searching results
          if (this.searchResults != null) ...[
            ChatListTitle(
              title: 'Resultados de búsqueda',
              context: context,
            ),
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
            ChatListTitle(
              title: 'Todas las conversaciones',
              context: context,
            ),
            for (ChatModel chat in this.allChats!)
              ChatListItem(
                chat: chat,
                context: context,
              ),
          ],
        ],
      ),
    );
  }
}

class ChatListTitle extends ListTile {
  ChatListTitle({
    required String title,
    required BuildContext context,
  }) : super(
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.08,
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              /// chat name
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
        );
}

class ChatListItem extends ListTile {
  ChatListItem({
    required ChatModel chat,
    required BuildContext context,
  }) : super(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/icons/avatar_icon.png'),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.08,
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              /// chat name
              Expanded(
                child: Text(
                  '${chat.chatName}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              /// chat date
              Text(
                '${DateFormat('MM-dd HH:mm').format(chat.lastActivity)}',
                style: Theme.of(context).textTheme.button,
              ),
            ],
          ),

          /// show last message chat
          subtitle: Text(
            chat.chatName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          /// when pressed then navigate to chats screens
          onTap: () => Navigator.of(context).pushNamed(
            ChatScreen.route,
            arguments: ChatScreen(
              chat: chat,
            ),
          ),
        );
}
