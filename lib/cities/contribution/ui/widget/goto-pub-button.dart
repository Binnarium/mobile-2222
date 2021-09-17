import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class GotoPubButton extends ElevatedButton {
  GotoPubButton({
    Key? key,
    required String pubUrl,
  }) : super(
          key: key,
          style: ElevatedButton.styleFrom(
            primary: Colors2222.black,
            elevation: 5,
          ),
          onPressed: () => launch(pubUrl),
          child: const Text(
            'Únete y construye nuestro Manifiesto',
          ),
        );
}
