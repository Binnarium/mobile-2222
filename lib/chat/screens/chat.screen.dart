import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ChatScreen extends StatefulWidget {
  static const route = "/chat";
  final ChatModel chat;

  final Stream<List<MessageModel>> messagesStream;

  ChatScreen({
    Key? key,
    required ChatModel chat,
  })  : this.chat = chat,
        this.messagesStream = FirebaseFirestore.instance
            .collection('chats')
            .doc(chat.id)
            .collection('messages')
            .snapshots()
            .map((event) =>
                event.docs.map((e) => MessageModel.fromMap(e.data())).toList()),
        super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  StreamSubscription? _messagesSub;
  List<MessageModel>? messages;
  @override
  void initState() {
    super.initState();
    _messagesSub = this
        .widget
        .messagesStream
        .listen((event) => this.setState(() => this.messages = event));
  }

  @override
  void dispose() {
    this._messagesSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors2222.primary,
      appBar: AppBar(
        title: Text(
          this.widget.chat.id,
          style: textTheme.subtitle1,
        ),
      ),
      body: ListView(
        children: [
          ///
          if (this.messages == null)
            AppLoading()
          else
            for (MessageModel message in this.messages!)
              ListTile(
                title: Text(message.id),
                subtitle: Text(
                  message.text ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {},
              ),
        ],
      ),
    );
  }
}
