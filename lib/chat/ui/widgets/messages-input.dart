import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/chat/ui/widgets/uploadMultimediaDialog.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/form/text-form-field-2222.widget.dart';

class MessageTextInput extends StatefulWidget {
  final TextEditingController myController;
  final ChatModel chat;

  MessageTextInput({
    Key? key,
    required this.chat,
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
          child: TextFormField222(
            controller: this.widget.myController,
            onValueChanged: (_) => _sendTextMessage,
            label: 'Escribe un mensaje...',
            showEnabledBorder: true,
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
                    chatId: this.widget.chat.id,
                    senderId: user.uid,
                  );
                });
          },
        ),

        /// send button
        IconButton(
          color: Colors2222.red,
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

    this._sendMessage(message);
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
