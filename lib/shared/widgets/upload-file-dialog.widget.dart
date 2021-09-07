import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/project/models/player-projects.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/services/load-player-information.service.dart';
import 'package:lab_movil_2222/services/upload-file.service.dart';
import 'package:lab_movil_2222/shared/widgets/buttonDialog.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

/// Creates alert dialog to upload file [color] is needed to create the button
/// with the city color
class UploadFileDialog extends StatefulWidget {
  final Color color;
  final String cityName;
  const UploadFileDialog({
    Key? key,
    required this.color,
    required this.cityName,
  }) : super(key: key);

  @override
  _UploadFileDialogState createState() => _UploadFileDialogState();
}

class _UploadFileDialogState extends State<UploadFileDialog> {
  UploadTask? task;
  String? userUID;
  File? file;
  String? fileName;
  PlayerModel? player;

  @override
  void initState() {
    super.initState();

    userUID = FirebaseAuth.instance.currentUser!.uid;
    LoadPlayerInformationService playerLoader = LoadPlayerInformationService();
    playerLoader.loadInformation(userUID!).then((value) => this.setState(() {
          this.player = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors2222.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            (file == null) ? 'Elige tu proyecto' : 'Sube tu proyecto',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 16,
          ),
          ButtonWidget(
            color: this.widget.color,
            text: 'Elegir archivo',
            icon: Icons.attach_file_rounded,
            onClicked: selectFile,
          ),
          SizedBox(height: 8),
          Text(
            fileName ?? 'No se ha seleccionado el archivo',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            height: 10,
          ),
          ButtonWidget(
            color: this.widget.color,
            icon: Icons.upload_file_rounded,
            text: 'Subir archivo',
            onClicked: uploadFile,
          ),
          SizedBox(
            height: 10,
          ),
          task != null ? buildUploadStatus(task!) : Container(),
        ],
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        withData: false,
        allowMultiple: false,
        allowedExtensions: (this.widget.cityName != "Angkor")
            ? ['pdf']
            : ['mp3', 'wav', 'm4p', 'ogg', 'wma', '3gp']);

    if (result == null) return;

    /// to get the path of the file
    final path = result.files.single.path!;

    setState(() {
      file = File(path);
      fileName = result.files.single.name;
    });
  }

  /// to upload a file
  Future uploadFile() async {
    if (file == null) return;

    final destination = 'players/$userUID/${this.widget.cityName}/$fileName';
    print("LOCATION: $destination");
    task = UploadFileToFirebaseService.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    bool medalFound = false;
    final snapshot = await task!.whenComplete(
      () => {
        /// seeks for all medals in the medals array
        player!.projectAwards.asMap().forEach((key, value) {
          if (value.cityId == this.widget.cityName) {
            medalFound = true;
            print('hay medalla');
          }
        }),

        /// if there is no medal with the city name, creates new one
        if (!medalFound)
          {
            print('no hay medalla'),
            UploadFileToFirebaseService.writeMedal(
                userUID!, this.widget.cityName),
          }
      },
    );
    final urlDownload = await snapshot.ref.getDownloadURL();

    /// creates a project instance

    PlayerProject currentProject = PlayerProject.fromMap({
      "asset": {"path": destination, "url": urlDownload},
      "cityID": this.widget.cityName,
      "kind": (this.widget.cityName != "Angkor") ? "PROJECT#PDF" : "PROJECT#MP3"
    });

    /// to write the project in the users project collection
    UploadFileToFirebaseService.writePlayerProjectFile(
        userUID!, currentProject);
    print('Download link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask uploadTask) =>
      StreamBuilder<TaskSnapshot>(
          stream: task!.snapshotEvents,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final snap = snapshot.data!;
              final progress = snap.bytesTransferred / snap.totalBytes;
              final percentage = (progress * 100).toStringAsFixed(1);
              return Text(
                (progress == 1.0)
                    ? '¡Subido con éxito!'
                    : 'Subiendo: $percentage %',
                style: Theme.of(context).textTheme.bodyText2,
              );
            } else {
              return Container();
            }
          });
}
