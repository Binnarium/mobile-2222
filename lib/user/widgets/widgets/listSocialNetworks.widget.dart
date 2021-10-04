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
  static const String FACEBOOK_URL = 'https://www.facebook.com/Labmovil2222/';
  static const String INSTAGRAM_URL = 'https://www.instagram.com/labmovil2222/';
  static const String TWITTER_URL = 'https://twitter.com/labmovil2222/';

  @override
  Widget build(BuildContext context) {
    String pageURL = '';

    if (iconURL == 'facebook') {
      pageURL = FACEBOOK_URL;
    } else if (iconURL == 'instagram') {
      pageURL = INSTAGRAM_URL;
    } else if (iconURL == 'twitter') {
      pageURL = TWITTER_URL;
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
