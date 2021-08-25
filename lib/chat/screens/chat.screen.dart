import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ChatScreen extends StatefulWidget {
  static const route = "/chat";
  final ChatModel chat;

  final Stream<List<MessageModel>> messagesStream;
  final ScrollController scrollController;

  ChatScreen({
    Key? key,
    required ChatModel chat,
  })  : this.chat = chat,
        this.messagesStream = FirebaseFirestore.instance
            .collection('chats')
            .doc(chat.id)
            .collection('messages')
            .orderBy('sendedDate')
            .limit(50)
            .snapshots()
            .map((event) =>
                event.docs.map((e) => MessageModel.fromMap(e.data())).toList()),
        this.scrollController = ScrollController(),
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
    Color incomingMessage = Colors2222.primary;

    return Scaffold(
      backgroundColor: Colors2222.white,
      appBar: AppBar(
        backgroundColor: Colors2222.primary,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/icons/avatar_icon.png'),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 25),
              child: Text(
                'Nombre Apellido',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          /// sended messages
          Expanded(
            child: ListView(
              controller: this.widget.scrollController,
              children: [
                if (this.messages == null)
                  AppLoading()
                else
                  for (MessageModel message in this.messages!)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.08,
                        vertical: 16,
                      ),
                      child: Row(
                        children: [
                          if (FirebaseAuth.instance.currentUser?.uid ==
                              message.senderId)
                            Flexible(child: Container(), flex: 1),

                          /// content
                          Flexible(
                            flex: 4,
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color:
                                    (FirebaseAuth.instance.currentUser?.uid ==
                                            message.senderId)
                                        ? Colors2222.grey
                                        : Colors2222.red,
                              ),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment:
                                    FirebaseAuth.instance.currentUser?.uid ==
                                            message.senderId
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                children: [
                                  /// sender
                                  Text(
                                    message.sender.displayName,
                                    style: TextStyle(
                                        fontFamily:
                                            textTheme.subtitle2!.fontFamily,
                                        color: Colors2222.black),
                                  ),

                                  /// content sended
                                  Markdown2222(
                                    data: message.text ?? '',
                                    color: FirebaseAuth
                                                .instance.currentUser?.uid ==
                                            message.senderId
                                        ? Colors2222.black
                                        : Colors2222.white,
                                    contentAlignment: FirebaseAuth
                                                .instance.currentUser?.uid ==
                                            message.senderId
                                        ? WrapAlignment.end
                                        : WrapAlignment.start,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          /// add item to take 1/4 of the space
                          if (FirebaseAuth.instance.currentUser?.uid !=
                              message.senderId)
                            Flexible(child: Container(), flex: 1),
                        ],
                      ),
                    ),
              ],
            ),
          ),

          /// send text area
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.08,
              vertical: 16,
            ),
            child: MessageTextInput(
              callback: _sendMessage,
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
}

class MessageTextInput extends StatefulWidget {
  final TextEditingController myController;
  final Function(MessageModel) callback;

  MessageTextInput({
    Key? key,
    required this.callback,
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
