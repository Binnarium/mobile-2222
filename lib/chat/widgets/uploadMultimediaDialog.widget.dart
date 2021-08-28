import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/models/player.dto.dart';
import 'package:lab_movil_2222/services/current-user.service.dart';
import 'package:lab_movil_2222/services/load-player-information.service.dart';
import 'package:lab_movil_2222/services/upload-file.service.dart';
import 'package:lab_movil_2222/themes/colors.dart';

/// Creates alert dialog to upload file [color] is needed to create the button
/// with the city color
class UploadMultimediaDialog extends StatefulWidget {
  final String messageId;
  final String senderId;
  final String chatId;
  final ChatParticipantModel sender;

  UploadMultimediaDialog({
    Key? key,
    required this.messageId,
    required this.senderId,
    required this.sender,
    required this.chatId,
  }) : super(key: key);

  @override
  _UploadMultimediaDialogState createState() => _UploadMultimediaDialogState();
}

class _UploadMultimediaDialogState extends State<UploadMultimediaDialog> {
  UploadTask? task;

  File? file;
  String? fileName;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.2),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        content: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: [
            RoundedIconButton(
              icon: Icons.photo,
              label: "Imagen",
              onPressed: () async {
                await uploadFile('MESSAGE#IMAGE');
              },
              color: Colors.purpleAccent.shade200,
            ),
            // RoundedIconButton(
            //   icon: Icons.description_rounded,
            //   label: "Documento",
            //   color: Colors.redAccent.shade200,
            //   onPressed: () async {
            //     await uploadFile('MESSAGE#IMAGE');
            //   },
            // ),
            RoundedIconButton(
              icon: Icons.movie,
              label: "Vídeo",
              color: Colors.orangeAccent.shade200,
              onPressed: () async {
                await uploadFile('MESSAGE#VIDEO');
              },
            )
          ],
        ),
      ),
    );
  }

  Future selectFile(String kind) async {
    /// allowed extensions depending on file kind
    Map<String, List<String>> allowedExtensions = {
      'MESSAGE#IMAGE': ['png', 'svg', 'jpg', 'jpeg'],
      'MESSAGE#VIDEO': ['mp4']
    };
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: allowedExtensions[kind]);

    if (result == null) return;

    /// to get the path of the file
    final path = result.files.single.path!;

    setState(() {
      file = File(path);
      fileName = result.files.single.name;
    });
  }

  /// to upload a file
  Future uploadFile(String kind) async {
    await selectFile(kind).whenComplete(
      () async {
        print('User UID: ${this.widget.senderId}');
        if (file == null) return;

        final destination = 'players/${this.widget.senderId}/assets/$fileName';
        print("LOCATION: $destination");

        task = UploadFileToFirebaseService.uploadFile(
            destination, file!, this.widget.senderId);
        setState(() {});

        if (task == null) return;

        final snapshot = await task!;

        final urlDownload = await snapshot.ref.getDownloadURL();
        if (kind == "MESSAGE#IMAGE") {
          _sendImageMessage(
              this.widget.messageId, fileName!, destination, urlDownload);
        } else if (kind == "MESSAGE#VIDEO") {}
        print('Download link: $urlDownload');
        Navigator.pop(context);
      },
    );
  }

  // Widget buildUploadStatus(UploadTask uploadTask) =>
  //     StreamBuilder<TaskSnapshot>(
  //       stream: task!.snapshotEvents,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           final snap = snapshot.data!;
  //           final progress = snap.bytesTransferred / snap.totalBytes;
  //           final percentage = (progress * 100).toStringAsFixed(1);
  //           return Text(
  //             (progress == 1.0)
  //                 ? '¡Subido con éxito!'
  //                 : 'Subiendo: $percentage %',
  //             style: Theme.of(context).textTheme.bodyText2,
  //           );
  //         } else {
  //           return Container();
  //         }
  //       },
  //     );

  Future<void> _sendImageMessage(
      String id, String filename, String path, String url) async {
    User user = FirebaseAuth.instance.currentUser!;
    Map<String, dynamic> imageMap = {
      'width': 0,
      'height': 0,
      'name': filename,
      'path': path,
      'url': url,
    };

    /// send text message
    ImageMessageModel image = ImageMessageModel(
        id: id,
        senderId: this.widget.sender.uid,
        sendedDate: DateTime.now(),
        sender: ChatParticipantModel(
          displayName:
              (user.displayName != '') ? user.displayName! : user.email!,
          uid: user.uid,
        ),
        kind: 'MESSAGE#IMAGE',
        image: ImageDto.fromMap(imageMap));

    print(image.toMap());
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(this.widget.chatId)
        .collection('messages')
        .doc(this.widget.messageId)
        .set(image.toMap());
  }
}

class RoundedIconButton extends StatelessWidget {
  final IconData icon;
  final String? label;
  final VoidCallback? onPressed;
  final Color color;
  const RoundedIconButton({
    Key? key,
    required this.icon,
    this.label = "",
    this.onPressed,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          child: Icon(
            icon,
            size: 32,
          ),
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(20),
              primary: color),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            label ?? '',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        )
      ],
    );
  }
}
