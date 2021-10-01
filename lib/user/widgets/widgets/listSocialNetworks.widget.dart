import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListSocialNetwork extends StatelessWidget {
  /// constructor
  const ListSocialNetwork({
    Key? key,
    required this.iconURL,
  }) : super(key: key);

  /// Name of social network
  final String iconURL;

  @override
  Widget build(BuildContext context) {
    String pageURL = '';

    /// TODO: refactor use static compiling
    if (iconURL == 'facebook') {
      pageURL = 'https://www.facebook.com/Labmovil2222/';
    } else if (iconURL == 'instagram') {
      pageURL = 'https://www.instagram.com/labmovil2222/';
    } else if (iconURL == 'twitter') {
      pageURL = 'https://twitter.com/labmovil2222/';
    }
    return IconButton(
      onPressed: () {
        launch(pageURL);
      },
      iconSize: 36,
      icon: ImageIcon(
        AssetImage('assets/images/$iconURL.png'),
      ),
    );
  }
}
