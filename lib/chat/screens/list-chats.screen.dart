import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/screens/chat.screen.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

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
    return Scaffold(
      backgroundColor: Colors2222.primary,
      appBar: AppBar(
        title: Text(
          'Comunidades 2222',
          style: textTheme.subtitle1,
        ),
      ),
      body: ListView(
        children: [
          /// if no chats loaded show loading icon
          if (this.chats == null)
            AppLoading()

          /// show a list of all chats
          else
            for (ChatModel chat in this.chats!)
              ListTile(
                title: Text('Identificador: ${chat.id}'),
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
