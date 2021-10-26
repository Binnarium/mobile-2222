import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/project/models/project-activity.model.dart';
import 'package:lab_movil_2222/cities/project/services/upload-file.service.dart';
import 'package:lab_movil_2222/cities/project/services/upload-project.service.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/player/services/current-player.service.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class UploadFileButton extends StatefulWidget {
  const UploadFileButton({
    Key? key,
    required this.city,
    required this.projectFileAllowed,
  }) : super(key: key);

  final CityModel city;
  final ProjectFileAllowed projectFileAllowed;

  @override
  _UploadFileButtonState createState() => _UploadFileButtonState();
}

class _UploadFileButtonState extends State<UploadFileButton> {
  @override
  ElevatedButton build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: widget.city.color,
        elevation: 4,
      ),

      ///Navigates to main screen
      onPressed: _uploadFile,
      icon: const Icon(Icons.file_upload_rounded),
      label: widget.projectFileAllowed == ProjectFileAllowed.AUDIO
          ? const Text('Subir Audio!')
          : const Text('Subir Documento PDF!'),
    );
  }

  StreamSubscription? _uploadFileSub;
  UploadProjectService get _uploadProjectService =>
      Provider.of<UploadProjectService>(context, listen: false);

  UploadPdfService get uploadFileService =>
      // (widget.projectFileAllowed == ProjectFileAllowed.AUDIO)
      //     ? Provider.of<UploadAudioService>(context, listen: false)
      //     :
      Provider.of<UploadPdfService>(context, listen: false);

  CurrentPlayerService get currentPlayerService =>
      Provider.of<CurrentPlayerService>(context, listen: false);

  @override
  void dispose() {
    _uploadFileSub?.cancel();
    super.dispose();
  }

  void _uploadFile() {
    final currentPlayer = currentPlayerService.currentPlayer;

    if (currentPlayer == null) return;

    if (_uploadFileSub != null) {
      return;
    }

    _uploadFileSub = uploadFileService
        .upload$(path: 'players/${currentPlayer.uid}/${widget.city.name}/')
        .switchMap(
          (file) => _uploadProjectService.project$(widget.city, file),
        )
        .listen(
      (sended) {
        /// TODO: catch error when error occurs
      },
      onDone: () {
        _uploadFileSub?.cancel();
        _uploadFileSub = null;
        Navigator.pop(context);
      },
    );
  }
}

// /// Creates alert dialog to upload file [color] is needed to create the button
// /// with the city color
// class UploadFileDialog extends StatefulWidget {
//   const UploadFileDialog({
//     Key? key,
//     required this.color,
//     required this.city,
//     required this.projectDto,
//     required this.currentPlayer,
//     required this.hasMedal,
//   }) : super(key: key);

//   final Color color;
//   final CityModel city;
//   final ProjectScreenModel projectDto;
//   final PlayerModel currentPlayer;
//   final bool hasMedal;

//   @override
//   _UploadFileDialogState createState() => _UploadFileDialogState();
// }

// class _UploadFileDialogState extends State<UploadFileDialog> {
//   StreamSubscription? _uploadFileSub;

//   UploadProjectService get _uploadProjectService =>
//       Provider.of<UploadProjectService>(context, listen: false);

//   @override
//   void initState() {
//     print('current player: ${widget.currentPlayer.displayName}');
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _uploadFileSub?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors2222.black,
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Elige tu proyecto',
//             style: Theme.of(context).textTheme.headline6,
//           ),
//           const SizedBox(
//             height: 16,
//           ),
//           const SizedBox(height: 8),
//           const SizedBox(
//             height: 10,
//           ),
//           ButtonWidget(
//             color: widget.color,
//             icon: Icons.upload_file_rounded,
//             text: 'Subir archivo',
//             onClicked: _uploadFile,
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//         ],
//       ),
//     );
//   }
