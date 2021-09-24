import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListSocialNetwork extends StatefulWidget {
  /// constructor
  const ListSocialNetwork({
    Key? key,
    required this.iconURL,
  }) : super(key: key);

  /// Name of social network
  final String iconURL;

  @override
  _ListSocialNetworkState createState() => _ListSocialNetworkState();
}

class _ListSocialNetworkState extends State<ListSocialNetwork> {
  @override
  Widget build(BuildContext context) {
    String pageURL = '';
    if (widget.iconURL == 'facebook') {
      pageURL = 'https://www.facebook.com/Labmovil2222/';
    } else if (widget.iconURL == 'instagram') {
      pageURL = 'https://www.instagram.com/labmovil2222/';
    } else if (widget.iconURL == 'twitter') {
      pageURL = 'https://twitter.com/labmovil2222/';
    }
    return ElevatedButton(
      onPressed: () {
        launch(pageURL);
      },
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          primary: Colors.black,
          onPrimary: Colors.white,
          elevation: 0),
      child: ImageIcon(
        AssetImage('assets/images/${widget.iconURL}.png'),
      ),
    );
  }
}
