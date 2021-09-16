import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/chat/services/list-messages.service.dart';
import 'package:lab_movil_2222/chat/ui/widgets/message.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:provider/provider.dart';

import 'chat-text-description.widget.dart';

class MessagesList extends StatefulWidget {
  final ScrollController scrollController;
  final ChatModel chatModel;

  MessagesList({
    Key? key,
    required ChatModel chatModel,
  })  : this.chatModel = chatModel,
        scrollController = ScrollController(),
        super(key: key);

  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  List<MessageModel>? messages;
  StreamSubscription? _messagesSub;

  ListMessagesService get _listMessagesService =>
      Provider.of<ListMessagesService>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _messagesSub = _listMessagesService.list$(widget.chatModel).listen((event) {
      /// add new messages
      setState(() => messages = event);
      Timer(Duration(milliseconds: 500), () {
        try {
          widget.scrollController.animateTo(
            widget.scrollController.position.maxScrollExtent,
            curve: Curves.ease,
            duration: Duration(milliseconds: 500),
          );
        } catch (error) {
          print('error al hacer scroll: $error');
        }
      });
    });
  }

  @override
  void dispose() {
    _messagesSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ListView(
      controller: widget.scrollController,
      children: [
        if (messages == null)
          AppLoading()
        else ...[
          /// about chats
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: Container(
                width: min(400, size.width * 0.8),
                child: ChatTextDescription.getChatText(
                  chat: widget.chatModel,
                  color: Colors2222.black.withOpacity(0.5),
                ),
              ),
            ),
          ),

          /// chats
          for (MessageModel message in messages!)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: 8,
              ),
              child: MessageWidget(message: message),
            ),
        ]
      ],
    );
  }
}
