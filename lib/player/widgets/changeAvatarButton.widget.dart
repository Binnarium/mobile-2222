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

  final UpdateAvatarService _updateAvatarService;

  ChangeAvatarButton({
    Key? key,
    required this.player,
  })  : this._updateAvatarService = UpdateAvatarService(),
        super(key: key);

  @override
  _ChangeAvatarButtonState createState() => _ChangeAvatarButtonState();
}

class _ChangeAvatarButtonState extends State<ChangeAvatarButton> {
  StreamSubscription? _uploadFileSub;

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
    if (this._uploadFileSub != null) return;
    String oldUrl = this.widget.player.avatarImage.url;
    print('old image url');
    UploadImageService uploadImageService =
        Provider.of<UploadImageService>(context, listen: false);

    this._uploadFileSub = uploadImageService
        .upload$('players/${this.widget.player.uid}/assets')
        .switchMap((image) =>
            this.widget._updateAvatarService.updateAvatar$(image, oldUrl))
        .listen((sended) {
      if (sended) print('Imagen cambiada correctamente');
    }, onDone: () {
      this._uploadFileSub?.cancel();
      this._uploadFileSub = null;
    });
  }
}
