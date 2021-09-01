import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/chat/ui/screens/chat-participants.screen.dart';
import 'package:lab_movil_2222/chat/ui/screens/detailed-multimedia.screen.dart';
import 'package:lab_movil_2222/chat/ui/widgets/message-list.widget.dart';
import 'package:lab_movil_2222/chat/ui/widgets/uploadMultimediaDialog.widget.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

class MessagesScreen extends StatefulWidget {
  static const route = "/messages";
  final ChatModel chat;

  MessagesScreen({
    Key? key,
    required ChatModel chat,
  })  : this.chat = chat,
        super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold2222.empty(
      backgroundColor: Colors2222.white,
      appBar: AppBar(
        backgroundColor: Colors2222.primary,
        titleSpacing: 0,
        title: Text(
          this.widget.chat.chatName,
          style: textTheme.subtitle1!.copyWith(
            color: Colors2222.white,
          ),
        ),
        actions: <IconButton>[
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () => Navigator.pushNamed(
              context,
              ChatParticipantsScreen.route,
              arguments: ChatParticipantsScreen(
                chat: this.widget.chat,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          /// sended messages
          Expanded(
            child: MessagesList(
              chatModel: this.widget.chat,
            ),
          ),

          /// send text area
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: 16,
            ),
            child: MessageTextInput(
              callback: _sendMessage,
              chatId: this.widget.chat.id,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage(MessageModel message) async {
    print(message.toMap());
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(this.widget.chat.id)
        .collection('messages')
        .doc(message.id)
        .set(message.toMap());
  }

  /// determines type of message (text, image, or video)
  Widget messageContent(MessageModel message) {
    switch (message.kind) {
      case "MESSAGE#TEXT":
        return Markdown2222(
          data: message.text ?? '',
          color: FirebaseAuth.instance.currentUser?.uid == message.senderId
              ? Colors2222.black
              : Colors2222.white,
          contentAlignment:
              FirebaseAuth.instance.currentUser?.uid == message.senderId
                  ? WrapAlignment.end
                  : WrapAlignment.start,
        );
      case "MESSAGE#IMAGE":
        if (message.asset?.url != null) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    DetailedMultimediaScreen.route,
                    arguments: DetailedMultimediaScreen(message: message),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    message.asset!.url,
                  ),
                ),
              ),
            ),
          );
        } else {
          return Image.asset('assets/images/video-placeholder.png');
        }
      case "MESSAGE#VIDEO":
        if (message.asset?.url != null) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Stack(children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/video-placeholder.png',
                  ),
                ),
              ),
              Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailedMultimediaScreen.route,
                      arguments: DetailedMultimediaScreen(message: message),
                    );
                  },
                  child: Center(
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.transparent.withOpacity(0.5),
                      size: 116,
                    ),
                  ),
                ),
              ),
            ]),
          );
        } else {
          return Image.asset('assets/images/video-placeholder.png');
        }

      default:
        return Container();
    }
  }
}

class MessageTextInput extends StatefulWidget {
  final TextEditingController myController;
  final Function(MessageModel) callback;
  final String chatId;

  MessageTextInput({
    Key? key,
    required this.callback,
    required this.chatId,
  })  : this.myController = TextEditingController(),
        super(key: key);

  @override
  _MessageTextInputState createState() => _MessageTextInputState();
}

class _MessageTextInputState extends State<MessageTextInput> {
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget.myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Row(
      children: [
        /// text input
        Expanded(
          child: TextField(
            cursorColor: Colors2222.black,
            style: TextStyle(color: Colors2222.black),
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors2222.black))),
            controller: this.widget.myController,
            onSubmitted: (_) => _sendTextMessage,
          ),
        ),

        /// multimedia button
        IconButton(
          color: Colors2222.black,
          icon: Icon(Icons.attach_file_rounded),
          onPressed: () async {
            return await showDialog(
                context: context,
                builder: (context) {
                  /// creates the alert dialog to upload file
                  return UploadMultimediaDialog(
                    messageId: _generateId(),
                    sender: ChatParticipantModel(
                      displayName: user.displayName ?? user.email!,
                      uid: user.uid,
                    ),
                    chatId: this.widget.chatId,
                    senderId: user.uid,
                  );
                });
          },
        ),

        /// send button
        IconButton(
          color: Colors2222.black,
          icon: Icon(Icons.send),
          onPressed: _sendTextMessage,
        )
      ],
    );
  }

  void _sendTextMessage() {
    /// validate input has text
    if (this.widget.myController.text == "") return;

    /// obtain data to send message
    final user = FirebaseAuth.instance.currentUser!;
    String id = _generateId();

    /// send text message
    TextMessageModel message = TextMessageModel(
      id: id,
      senderId: user.uid,
      text: this.widget.myController.text,
      sendedDate: DateTime.now(),
      sender: ChatParticipantModel(
        displayName: user.displayName ?? user.email!,
        uid: user.uid,
      ),
      kind: 'MESSAGE#TEXT',
    );

    this.widget.callback(message);
    this.widget.myController.clear();
  }

  String _generateId({int size = 10}) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    String id = String.fromCharCodes(
      Iterable.generate(
        size,
        (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
      ),
    );
    return id;
  }
}
