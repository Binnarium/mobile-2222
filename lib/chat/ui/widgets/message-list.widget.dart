import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/chat/services/delete-message.service.dart';
import 'package:lab_movil_2222/chat/services/list-messages.service.dart';
import 'package:lab_movil_2222/chat/ui/widgets/message.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:provider/provider.dart';

import 'chat-text-description.widget.dart';

class MessagesList extends StatefulWidget {
  /// constructor
  MessagesList({
    Key? key,
    required ChatModel chatModel,
  })  : chatModel = chatModel,
        scrollController = ScrollController(),
        super(key: key);

  final ScrollController scrollController;
  final ChatModel chatModel;

  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  List<MessageModel>? messages;
  StreamSubscription? _messagesSub;
  StreamSubscription? _deleteMessageSub;

  ListMessagesService get _listMessagesService =>
      Provider.of<ListMessagesService>(context, listen: false);

  DeleteMessageService get _deleteMessagesService =>
      Provider.of<DeleteMessageService>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _messagesSub = _listMessagesService.list$(widget.chatModel).listen((event) {
      /// add new messages
      setState(() => messages = event);
      Timer(const Duration(milliseconds: 500), () {
        try {
          widget.scrollController.animateTo(
            widget.scrollController.position.maxScrollExtent,
            curve: Curves.ease,
            duration: const Duration(milliseconds: 500),
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
    _deleteMessageSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ListView(
      controller: widget.scrollController,
      children: [
        if (messages == null)
          const AppLoading()
        else ...[
          /// about chats
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: SizedBox(
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
              child: MessageWidget(
                message: message,
                longPressFunction: (message) {
                  if (message.sendedByMe) {
                    showModalBottomSheet<Widget>(
                        context: context,
                        builder: (context) {
                          return ListTile(
                            leading: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                              size: 30,
                            ),
                            title: Text(
                              'Eliminar mensaje',
                              style: textTheme.bodyText2
                                  ?.apply(color: Colors.black),
                            ),
                            onTap: () {
                              print(
                                  'eliminando mensaje: ${message.text} del chat: ${widget.chatModel.id}');
                              _deleteMessage(message);
                              Navigator.pop(context);
                            },
                            tileColor: Colors2222.white,
                          );
                        });
                  } else {
                    print('sólo borro para mí');
                  }
                },
              ),
            ),
        ]
      ],
    );
  }

  void _deleteMessage(MessageModel message) {
    if (_deleteMessageSub != null) {
      return;
    }

    _deleteMessageSub = _deleteMessagesService
        .deleteMessage$(chat: widget.chatModel, message: message)
        .listen((deleted) {
      if (!deleted) {
        print('no se borró');
      }
    }, onDone: () {
      _deleteMessageSub?.cancel();
      _deleteMessageSub = null;
    });
  }
}
