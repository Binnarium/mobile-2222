import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/image/services/upload-image.service.dart';
import 'package:lab_movil_2222/assets/video/services/upload-video.service.dart';
import 'package:lab_movil_2222/chat/chats/models/chat.model.dart';
import 'package:lab_movil_2222/chat/services/send-message.service.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/form/text-form-field-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class MessageTextInput extends StatefulWidget {
  /// constructor
  MessageTextInput({
    Key? key,
    required this.chat,
  })  : messageInput = TextEditingController(),
        super(key: key);

  /// params
  final TextEditingController messageInput;

  final ChatModel chat;

  @override
  _MessageTextInputState createState() => _MessageTextInputState();
}

class _MessageTextInputState extends State<MessageTextInput> {
  StreamSubscription? _sendMessageSub;
  bool showOtherSendOptions = false;
  bool sendingMessage = false;

  SendMessagesService get _sendMessagesService =>
      Provider.of<SendMessagesService>(context, listen: false);

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget.messageInput.dispose();
    _sendMessageSub?.cancel();
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
                controller: widget.messageInput,
                label: 'Escribe un mensaje...',
                showEnabledBorder: true,
              ),
            ),

            /// multimedia button
            IconButton(
              color: Colors2222.black,
              icon: const Icon(Icons.attach_file_rounded),
              onPressed: () => setState(() => showOtherSendOptions = true),
            ),

            /// send button
            IconButton(
              color: Colors2222.red,
              icon: const Icon(Icons.send_rounded),
              onPressed: _sendTextMessage,
            )
          ],
        ),

        /// other attachment options
        ///
        /// created with a invisible container to make it relative to
        /// position a floating window above
        if (showOtherSendOptions)
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
                    icon: const Icon(Icons.image_rounded),
                    onPressed: _sendImageMessage,
                  ),
                  // disable video send
                  // IconButton(
                  //     color: Colors2222.white,
                  //     icon: const Icon(Icons.videocam_rounded),
                  //     onPressed: _sendVideoMessage),

                  /// space items away from each other
                  Expanded(child: Container()),
                  IconButton(
                    color: Colors2222.white,
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () =>
                        setState(() => showOtherSendOptions = false),
                  ),
                ],
              ),
            ),
          ),

        if (sendingMessage)
          Positioned(
            left: 0,
            right: 0,
            top: -15,
            child: Text(
              'Enviando mensaje ...',
              style: Theme.of(context).primaryTextTheme.overline,
            ),
          ),
      ],
    );
  }

  void _sendTextMessage() {
    /// validate input has text
    if (widget.messageInput.text == '') {
      return;
    }
    if (_sendMessageSub != null) {
      return;
    }

    setState(() {
      sendingMessage = true;
    });

    _sendMessageSub = _sendMessagesService
        .text$(widget.chat, widget.messageInput.text)
        .listen((sended) {
      if (!sended) {
        ScaffoldMessenger.of(context).showSnackBar(
          const ChatSnackbarMessages.textNotSended(),
        );
      } else
        widget.messageInput.clear();
    }, onDone: () {
      setState(() {
        sendingMessage = false;
      });
      _sendMessageSub?.cancel();
      _sendMessageSub = null;
    });
  }

  /// calls the provider to upload image.
  UploadImageService get uploadImageService =>
      Provider.of<UploadImageService>(context, listen: false);

  void _sendImageMessage() {
    /// checks if the stream is bussy
    if (_sendMessageSub != null) {
      return;
    }

    setState(() {
      sendingMessage = true;
    });

    /// use the message sub stream with the upload$ stream
    _sendMessageSub = uploadImageService
        .upload$('/chats/${widget.chat.id}/assets/images')
        .switchMap(
          (image) =>

              /// calls the image$ stream
              _sendMessagesService.image$(widget.chat, image),
        )

        /// checks if the video is sended or not
        .listen(
      (sended) {
        if (!sended) {
          ScaffoldMessenger.of(context).showSnackBar(
            const ChatSnackbarMessages.textNotSended(),
          );
        }
      },
      onError: (Object error) {
        print(error);
        if (error.runtimeType == ImageNotLoaded)
          ScaffoldMessenger.of(context).showSnackBar(
            const ChatSnackbarMessages.imageNotLoaded(),
          );
        else
          ScaffoldMessenger.of(context).showSnackBar(
            const ChatSnackbarMessages.textNotSended(),
          );
      },
      onDone: () {
        setState(() {
          sendingMessage = false;
        });

        _sendMessageSub?.cancel();
        _sendMessageSub = null;
        widget.messageInput.clear();
      },
    );
  }

  /// method to send a video message
  void _sendVideoMessage() {
    /// checks if the stream is bussy
    if (_sendMessageSub != null) {
      return;
    }
    setState(() {
      sendingMessage = true;
    });

    /// calls the provider to upload image.
    final UploadVideoService uploadVideoService =
        Provider.of<UploadVideoService>(context, listen: false);

    /// use the message sub stream with the upload$ stream
    _sendMessageSub = uploadVideoService
        .upload$('/chats/${widget.chat.id}/assets/videos')
        .switchMap(
          (video) =>

              /// calls the video$ stream
              _sendMessagesService.video$(widget.chat, video),
        )

        /// checks if the video is sended or not
        .listen(
      (sended) {
        if (!sended) {
          ScaffoldMessenger.of(context).showSnackBar(
            const ChatSnackbarMessages.textNotSended(),
          );
        }
      },
      onError: (Object error) {
        if (error.runtimeType == VideoNotLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const ChatSnackbarMessages.videoNotLoaded(),
          );
        } else
          ScaffoldMessenger.of(context).showSnackBar(
            const ChatSnackbarMessages.videoNotSended(),
          );
      },
      onDone: () {
        setState(() {
          sendingMessage = false;
        });
        _sendMessageSub?.cancel();
        _sendMessageSub = null;
        widget.messageInput.clear();
      },
    );
  }
}

class ChatSnackbarMessages extends SnackBar {
  const ChatSnackbarMessages.textNotSended({Key? key})
      : super(
          key: key,
          content: const Text('No se pudo enviar el mensaje'),
        );

  const ChatSnackbarMessages.imageNotLoaded({Key? key})
      : super(
          key: key,
          content: const Text('No se pudo cargar la imagen a enviar'),
        );
  const ChatSnackbarMessages.imageNotSended({Key? key})
      : super(
          key: key,
          content: const Text('No se pudo enviar la imagen'),
        );
  const ChatSnackbarMessages.videoNotLoaded({Key? key})
      : super(
          key: key,
          content: const Text('No se pudo cargar el video a enviar'),
        );
  const ChatSnackbarMessages.videoNotSended({Key? key})
      : super(
          key: key,
          content: const Text('No se pudo enviar el video'),
        );
}
