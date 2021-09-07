import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/image/services/upload-image.service.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/services/send-message.service.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/form/text-form-field-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

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
                    onPressed: this._sendImageMessage,
                  ),
                  IconButton(
                      color: Colors2222.white,
                      icon: Icon(Icons.videocam_rounded),
                      onPressed: () {}),

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
    if (this._sendMessageSub != null) return;

    this._sendMessageSub = this
        .widget
        ._sendMessagesService
        .text$(this.widget.chat, this.widget.messageInput.text)
        .listen((sended) {
      if (!sended)
        ScaffoldMessenger.of(context).showSnackBar(
          ChatSnackbarMessages.textNotSended(),
        );

      this._sendMessageSub?.cancel();
      this._sendMessageSub = null;
      this.widget.messageInput.clear();
    });
  }

  void _sendImageMessage() {
    /// validate input has text
    if (this._sendMessageSub != null) return;
    UploadImageService uploadImageService =
        Provider.of<UploadImageService>(context, listen: false);
    this._sendMessageSub = uploadImageService
        .upload$('/chats/${this.widget.chat.id}/assets/images')
        .switchMap(
          (image) =>
              this.widget._sendMessagesService.image$(this.widget.chat, image),
        )
        .listen((sended) {
      if (!sended)
        ScaffoldMessenger.of(context).showSnackBar(
          ChatSnackbarMessages.textNotSended(),
        );
    }, onError: (error) {
      if (error.runtimeType == ImageNotLoaded)
        ScaffoldMessenger.of(context).showSnackBar(
          ChatSnackbarMessages.imageNotLoaded(),
        );
      ScaffoldMessenger.of(context).showSnackBar(
        ChatSnackbarMessages.textNotSended(),
      );
    }, onDone: () {
      this._sendMessageSub?.cancel();
      this._sendMessageSub = null;
      this.widget.messageInput.clear();
    });
  }

  // void _sendMultimediaMessage(String kind) async {
  //   File file = File('');
  //   String urlDownload = "";
  //   dynamic message;

  //   /// check message kind
  //   if (kind == "MESSAGE#IMAGE") {
  //     /// user picks file
  //     file = await selectMultimediaFile(kind);
  //     if (file.path != "") {
  //       /// method to upload to firebase storage
  //       urlDownload = await uploadMultimediaFile(file, kind);

  //       /// checks if urlDownload isn't null
  //       if (urlDownload != "") {
  //         /// builds the image Map
  //         Map<String, dynamic> imageMap = {
  //           'width': 0,
  //           'height': 0,
  //           'name': file.path.split("/").last,
  //           'path': file.path,
  //           'url': urlDownload,
  //         };

  //         /// creates the imageDto based on map above

  //         message = ImageDto.fromMap(imageMap);
  //         print('mensaje : ${message.name}');
  //       } else {
  //         print('url vacía');
  //         return;
  //       }
  //     } else {
  //       print('usuario no seleccionó imagen');
  //       return;
  //     }
  //   } else if (kind == "MESSAGE#VIDEO") {
  //     /// user picks file
  //     file = await selectMultimediaFile(kind);
  //     if (file.path != "") {
  //       /// method to upload to firebase storage
  //       urlDownload = await uploadMultimediaFile(file, kind);

  //       /// checks if urlDownload isn't null
  //       if (urlDownload != "") {
  //         Map<String, dynamic> videoMap = {
  //           'format': '',
  //           'duration': 0,
  //           'name': file.path.split("/").last,
  //           'path': file.path,
  //           'url': urlDownload,
  //         };

  //         message = VideoDto.fromMap(videoMap);
  //       } else {
  //         print('url vacía');
  //         return;
  //       }
  //     } else {
  //       print('usuario no seleccionó video');
  //       return;
  //     }
  //   }

  //   // /// checks if there is a _sendMessageSub
  //   // if (this._sendMessageSub != null) return;

  //   // print('mensaje : ${message.toString()}');
  //   // if (message != null) {
  //   //   print('entró a que message!= null del servicio');

  //   //   /// begins the stream to upload message
  //   //   await this
  //   //       .widget
  //   //       ._sendMessagesService
  //   //       .multimedia(this.widget.chat, message, kind);

  //   //   this._sendMessageSub?.cancel();
  //   //   this._sendMessageSub = null;
  //   //   this.widget.messageInput.clear();
  //   // }
  // }
}

class ChatSnackbarMessages extends SnackBar {
  /// TODO: add docs
  ChatSnackbarMessages.textNotSended({Key? key})
      : super(
          key: key,
          content: Text('No se pudo enviar el mensaje'),
        );

  ChatSnackbarMessages.imageNotLoaded({Key? key})
      : super(
          key: key,
          content: Text('No se pudo cargar la imagen a enviar'),
        );
  ChatSnackbarMessages.imageNotSended({Key? key})
      : super(
          key: key,
          content: Text('No se pudo enviar la imagen'),
        );
}
