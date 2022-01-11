import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/audio/services/upload-audio.service.dart';
import 'package:lab_movil_2222/cities/project/models/project-activity.model.dart';
import 'package:lab_movil_2222/cities/project/services/upload-file.service.dart';
import 'package:lab_movil_2222/cities/project/services/upload-project.service.dart';
import 'package:lab_movil_2222/home-map/models/city.dto.dart';
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

  UploadAudioService get uploadAudioService =>
      Provider.of<UploadAudioService>(context, listen: false);

  UploadPdfService get uploadPdfService =>
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Ya se esta subiendo un archivo',
          ),
        ),
      );

      return;
    }
    if (widget.projectFileAllowed == ProjectFileAllowed.AUDIO) {
      _uploadFileSub = uploadAudioService
          .upload$(path: 'players/${currentPlayer.uid}/${widget.city.id}/')
          .switchMap(
            (file) => _uploadProjectService.project$(widget.city, file),
          )
          .listen(
        (sended) {
          ScaffoldMessenger.of(context).clearSnackBars();
          if (!sended)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'No se pudo subir el documento, vuelve a intentarlo',
                ),
              ),
            );
        },
        onDone: () {
          _uploadFileSub?.cancel();
          _uploadFileSub = null;
        },
      );
    } else {
      _uploadFileSub = uploadPdfService
          .upload$(path: 'players/${currentPlayer.uid}/${widget.city.id}/')
          .switchMap(
            (file) => _uploadProjectService.project$(widget.city, file),
          )
          .listen(
        (sended) {
          ScaffoldMessenger.of(context).clearSnackBars();
          if (!sended)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'No se pudo subir el documento, vuelve a intentarlo',
                ),
              ),
            );
        },
        onDone: () {
          _uploadFileSub?.cancel();
          _uploadFileSub = null;
        },
      );
    }
  }
}
