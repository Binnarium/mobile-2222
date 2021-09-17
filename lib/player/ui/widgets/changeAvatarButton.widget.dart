import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/image/services/upload-image.service.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/update-avatar.service.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class ChangeAvatarButton extends StatefulWidget {
  /// player is required to avoid charging again the player service stream
  final PlayerModel player;

  ChangeAvatarButton({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  _ChangeAvatarButtonState createState() => _ChangeAvatarButtonState();
}

class _ChangeAvatarButtonState extends State<ChangeAvatarButton> {
  StreamSubscription? _uploadFileSub;

  UpdateAvatarService get _updateAvatarService =>
      Provider.of<UpdateAvatarService>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // onPressed: _changeAvatar,
      onPressed: _changeAvatar,
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          primary: Colors.black,
          onPrimary: Colors.white,
          elevation: 0),
      child: Icon(Icons.photo_camera_rounded),
    );
  }

  /// method to change the avatarImage
  void _changeAvatar() async {
    if (_uploadFileSub != null) return;
    String oldUrl = widget.player.avatarImage.url;
    print('old image url');
    UploadImageService uploadImageService =
        Provider.of<UploadImageService>(context, listen: false);

    _uploadFileSub = uploadImageService
        .upload$('players/${widget.player.uid}/assets')
        .switchMap((image) => _updateAvatarService.updateAvatar$(image, oldUrl))
        .listen((sended) {
      if (sended) print('Imagen cambiada correctamente');
    }, onDone: () {
      _uploadFileSub?.cancel();
      _uploadFileSub = null;
    });
  }
}
