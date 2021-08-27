import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/player-search-result.model.dart';
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

  List<ChatModel>? chats;

  final TextEditingController _searchController = TextEditingController();
  List<PlayerSearchResultModel>? playersResult;
  @override
  void initState() {
    super.initState();
    _chatsSub = this
        .widget
        .userChats
        .listen((event) => this.setState(() => this.chats = event));
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
                    this.playersResult = null;
                  });
                  return;
                }
                HttpsCallable searchPlayers =
                    FirebaseFunctions.instance.httpsCallable('searchPlayer');
                final results = await searchPlayers<String>({"query": value});
                final List<Map<String, dynamic>>? data =
                    (jsonDecode(results.data) as List<dynamic>)
                        .map((e) => e as Map<String, dynamic>)
                        .toList();
                List<PlayerSearchResultModel>? playersResult = data
                    ?.map(
                      (dynamic e) => PlayerSearchResultModel.fromMap(e),
                    )
                    .toList();

                this.setState(() {
                  this.playersResult = playersResult;
                });
              },
              prefixIcon: Icons.search,
            ),
          ),

          /// TODO:
          if (this.playersResult != null) ...[
            for (PlayerSearchResultModel player in this.playersResult!)
              Padding(
                padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 20),
                child: Text(player.displayName),
              ),
          ],

          /// if no chats loaded show loading icon
          if (this.chats == null)
            AppLoading()

          /// show a list of all chats
          else
            for (ChatModel chat in this.chats!)
              ListTile(
                ///TODO implementar esta linea cuando funcione lastMessage
                /// trailing: Text('${chat.lastMessage!.sendedDate}'),
                trailing: Text('16:50'),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/avatar_icon.png'),
                ),
                title: Text('${chat.participantsNames}'),
                subtitle: Text(
                  chat.participantsNames,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () => Navigator.of(context).pushNamed(
                  ChatScreen.route,
                  arguments: ChatScreen(
                    chat: chat,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
