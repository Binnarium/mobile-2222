import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/services/send-message.service.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/form/text-form-field-2222.widget.dart';

class MessageTextInput extends StatefulWidget {
  final TextEditingController messageInput;

  final ChatModel chat;

  final SendMessagesService _sendMessagesService;

  MessageTextInput({
    Key? key,
    required this.chat,
  })  : this.messageInput = TextEditingController(),
        this._sendMessagesService = SendMessagesService(),
        super(key: key);

  @override
  _MessageTextInputState createState() => _MessageTextInputState();
}

class _MessageTextInputState extends State<MessageTextInput> {
  StreamSubscription? _sendMessageSub;
  bool showOtherSendOptions = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget.messageInput.dispose();
    this._sendMessageSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        /// base input with send options and show attachment options
        Row(
          children: [
            /// text input
            Expanded(
              child: TextFormField222(
                controller: this.widget.messageInput,
                label: 'Escribe un mensaje...',
                showEnabledBorder: true,
              ),
            ),

            /// multimedia button
            IconButton(
              color: Colors2222.black,
              icon: Icon(Icons.attach_file_rounded),
              onPressed: () =>
                  this.setState(() => this.showOtherSendOptions = true),
            ),

            /// send button
            IconButton(
              color: Colors2222.red,
              icon: Icon(Icons.send_rounded),
              onPressed: _sendTextMessage,
            )
          ],
        ),

        /// other attachment options
        ///
        /// created with a invisible container to make it relative to
        /// position a floating window above
        if (this.showOtherSendOptions)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors2222.red,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  /// multimedia button
                  IconButton(
                    color: Colors2222.white,
                    icon: Icon(Icons.image_rounded),
                    onPressed: () {
                      print('object');
                    },
                  ),
                  IconButton(
                    color: Colors2222.white,
                    icon: Icon(Icons.videocam_rounded),
                    onPressed: () {
                      print('object');
                    },
                  ),

                  /// space items away from each other
                  Expanded(child: Container()),
                  IconButton(
                    color: Colors2222.white,
                    icon: Icon(Icons.close_rounded),
                    onPressed: () =>
                        this.setState(() => this.showOtherSendOptions = false),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  void _sendTextMessage() {
    /// validate input has text
    if (this.widget.messageInput.text == "") return;
    print(this.widget.messageInput.text);
    print(this._sendMessageSub);

    if (this._sendMessageSub != null) return;

    this._sendMessageSub = this
        .widget
        ._sendMessagesService
        .text$(this.widget.chat, this.widget.messageInput.text)
        .listen((sended) {
      if (!sended)
        ScaffoldMessenger.of(context)
            .showSnackBar(MessageNotSended.textNotSended());

      this._sendMessageSub?.cancel();
      this._sendMessageSub = null;
      this.widget.messageInput.clear();
    });
  }
}

class MessageNotSended extends SnackBar {
  /// TODO:_add docs
  MessageNotSended.textNotSended({Key? key})
      : super(
          key: key,
          content: Text('No se pudo enviar el mensaje'),
        );
}
