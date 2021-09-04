import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/services/send-message.service.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/services/upload-file.service.dart';
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
                      _sendMultimediaMessage("MESSAGE#IMAGE");
                    },
                  ),
                  IconButton(
                    color: Colors2222.white,
                    icon: Icon(Icons.videocam_rounded),
                    onPressed: () {
                      _sendMultimediaMessage("MESSAGE#VIDEO");
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
    print('antes del servicio');
    if (this._sendMessageSub != null) return;
    print('entró al servicio');
    this._sendMessageSub = this
        .widget
        ._sendMessagesService
        .text$(this.widget.chat, this.widget.messageInput.text, "MESSAGE#TEXT")
        .listen((sended) {
      if (!sended)
        ScaffoldMessenger.of(context)
            .showSnackBar(MessageNotSended.textNotSended());

      this._sendMessageSub?.cancel();
      this._sendMessageSub = null;
      this.widget.messageInput.clear();
    });
  }

  void _sendMultimediaMessage(String kind) async {
    File file = File('');
    String urlDownload = "";
    dynamic message;

    /// check message kind
    if (kind == "MESSAGE#IMAGE") {
      /// user picks file
      file = await selectMultimediaFile(kind);
      if (file.path != "") {
        /// method to upload to firebase storage
        urlDownload = await uploadMultimediaFile(file, kind);

        /// checks if urlDownload isn't null
        if (urlDownload != "") {
          /// builds the image Map
          Map<String, dynamic> imageMap = {
            'width': 0,
            'height': 0,
            'name': file.path.split("/").last,
            'path': file.path,
            'url': urlDownload,
          };

          /// creates the imageDto based on map above

          message = ImageDto.fromMap(imageMap);
          print('mensaje : ${message.name}');
        } else {
          print('url vacía');
          return;
        }
      } else {
        print('usuario no seleccionó imagen');
        return;
      }
    } else if (kind == "MESSAGE#VIDEO") {
      /// user picks file
      file = await selectMultimediaFile(kind);
      if (file.path != "") {
        /// method to upload to firebase storage
        urlDownload = await uploadMultimediaFile(file, kind);

        /// checks if urlDownload isn't null
        if (urlDownload != "") {
          Map<String, dynamic> videoMap = {
            'format': '',
            'duration': 0,
            'name': file.path.split("/").last,
            'path': file.path,
            'url': urlDownload,
          };

          message = VideoDto.fromMap(videoMap);
        } else {
          print('url vacía');
          return;
        }
      } else {
        print('usuario no seleccionó video');
        return;
      }
    }

    /// checks if there is a _sendMessageSub
    if (this._sendMessageSub != null) return;

    print('mensaje : ${message.toString()}');
    if (message != null) {
      print('entró a que message!= null del servicio');

      /// begins the stream to upload message
      await this
          .widget
          ._sendMessagesService
          .multimedia(this.widget.chat, message, kind);

      this._sendMessageSub?.cancel();
      this._sendMessageSub = null;
      this.widget.messageInput.clear();
    }
  }

  Future<File> selectMultimediaFile(String kind) async {
    /// allowed extensions depending on file kind
    Map<String, List<String>> allowedExtensions = {
      'MESSAGE#IMAGE': ['png', 'svg', 'jpg', 'jpeg'],
      'MESSAGE#VIDEO': ['mp4', 'avi', 'wmv', 'amv', 'm4v', 'gif']
    };
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: allowedExtensions[kind]);

    if (result == null) return File('');

    /// to get the path of the file
    final path = result.files.single.path!;

    return File(path);
  }

  /// to upload a file
  Future<String> uploadMultimediaFile(File file, String kind) async {
    String urlDownload = "";

    final destination =
        'chats/${this.widget.chat.id}/files/${file.path.split("/").last}';
    print("LOCATION: $destination");

    UploadTask? task =
        UploadFileToFirebaseService.uploadFile(destination, file);

    if (task == null) return "";

    final snapshot = await task;

    urlDownload = await snapshot.ref.getDownloadURL();

    print('Download link: $urlDownload');
    return urlDownload;
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
