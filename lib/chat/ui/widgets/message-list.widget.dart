import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/message-with-snapshot.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/chat/services/delete-message.service.dart';
import 'package:lab_movil_2222/chat/services/list-messages.service.dart';
import 'package:lab_movil_2222/chat/ui/widgets/message.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:provider/provider.dart';

/// List view containg all messages sended
class MessagesList extends StatefulWidget {
  const MessagesList({
    Key? key,
    required this.chatModel,
  }) : super(key: key);

  final ChatModel chatModel;

  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final ScrollController scrollController = ScrollController();

  List<MessageWithSnapshotModel> messages = [];

  StreamSubscription? _deleteMessageSub;

  ListMessagesService get _listMessagesService =>
      Provider.of<ListMessagesService>(context, listen: false);

  DeleteMessageService get _deleteMessagesService =>
      Provider.of<DeleteMessageService>(context, listen: false);

  @override
  void initState() {
    super.initState();
    loadMessages();
    // _loadMessagesSub = _listMessagesService.list$(widget.chatModel).listen((event) {
    //   /// add new messages
    //   setState(() => messages = event);
    //   Timer(const Duration(milliseconds: 500), () {
    //     try {
    //       scrollController.animateTo(
    //         scrollController.position.maxScrollExtent,
    //         curve: Curves.ease,
    //         duration: const Duration(milliseconds: 500),
    //       );
    //     } catch (error) {
    //       print('error al hacer scroll: $error');
    //     }
    //   });
    // });
  }

  Future<void> loadMessages() async {
    final MessageWithSnapshotModel? lastLoadedMessage =
        messages.isEmpty ? null : messages.first;

    final newLoadedMessages = await _listMessagesService.list$(
      widget.chatModel,
      lastLoadedMessageSnapshot: lastLoadedMessage?.snapshot,
    );
    
    setState(() => messages.insertAll(0, newLoadedMessages));
  }

  @override
  void dispose() {
    _deleteMessageSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return RefreshIndicator(
      onRefresh: () async {
        loadMessages();
      },
      child: ListView.builder(
        shrinkWrap: true,
        controller: scrollController,
        itemCount: messages.length,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
            vertical: 8,
          ),
          child: MessageWidget(
            message: messages[index].message,
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
                          style:
                              textTheme.bodyText2?.apply(color: Colors.black),
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
      ),
    );

    /// about chats
    // Padding(
    //   padding: const EdgeInsets.only(top: 40.0),
    //   child: Center(
    //     child: SizedBox(
    //       width: min(400, size.width * 0.8),
    //       child: ChatTextDescription.getChatText(
    //         chat: widget.chatModel,
    //         color: Colors2222.black.withOpacity(0.5),
    //       ),
    //     ),
    //   ),
    // ),
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
