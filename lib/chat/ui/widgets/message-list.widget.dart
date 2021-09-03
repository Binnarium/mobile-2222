import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/chat/services/list-messages.service.dart';
import 'package:lab_movil_2222/chat/ui/screens/chat-participants.screen.dart';
import 'package:lab_movil_2222/chat/ui/widgets/message.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class MessagesList extends StatefulWidget {
  final Stream<List<MessageModel>> messagesStream;
  final ScrollController scrollController;

  MessagesList({
    Key? key,
    required ChatModel chatModel,
  })  : this.messagesStream = ListMessagesService.instance.list$(chatModel),
        this.scrollController = ScrollController(),
        super(key: key);

  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  List<MessageModel>? messages;
  StreamSubscription? _messagesSub;

  @override
  void initState() {
    super.initState();
    _messagesSub = this.widget.messagesStream.listen((event) {
      /// add new messages
      this.setState(() => this.messages = event);
      Timer(Duration(milliseconds: 500), () {
        try {
          this.widget.scrollController.animateTo(
                this.widget.scrollController.position.maxScrollExtent,
                curve: Curves.ease,
                duration: Duration(milliseconds: 500),
              );
        } catch (error) {}
      });
    });
  }

  @override
  void dispose() {
    this._messagesSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return ListView(
      controller: this.widget.scrollController,
      children: [
        if (this.messages == null)
          AppLoading()
        else ...[
          /// about chats
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: Container(
                width: min(400, size.width * 0.8),
                child: Markdown2222(
                  data: chatsInfo,
                  color: Colors2222.black.withOpacity(0.5),
                  contentAlignment: WrapAlignment.center,
                ),
              ),
            ),
          ),

          /// chats
          for (MessageModel message in this.messages!)
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
