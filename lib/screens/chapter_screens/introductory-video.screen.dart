import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city-introductory-video.dto.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/services/load-city-introductory-video.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/background-video.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class IntroductoryVideoScreen extends StatefulWidget {
  static const String route = '/introductory-video';

  final CityModel city;

  IntroductoryVideoScreen({
    Key? key,
    required CityModel city,
  })  : this.city = city,
        super(key: key);

  @override
  _IntroductoryVideoScreenState createState() =>
      _IntroductoryVideoScreenState();
}

class _IntroductoryVideoScreenState extends State<IntroductoryVideoScreen> {
  CityIntroductoryVideoDto? introductoryVideo;

  StreamSubscription? _loadIntroductoryVideoSub;

  @override
  void initState() {
    super.initState();

    LoadCityIntroductoryVideoService loadIntroductoryVideoService =
        Provider.of<LoadCityIntroductoryVideoService>(this.context,
            listen: false);

    this._loadIntroductoryVideoSub =
        loadIntroductoryVideoService.load$(this.widget.city).listen(
      (introductoryVideoDto) {
        if (this.mounted)
          this.setState(() {
            this.introductoryVideo = introductoryVideoDto;
          });
      },
    );
  }

  @override
  void dispose() {
    this._loadIntroductoryVideoSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2222.city(
      city: this.widget.city,
      backgrounds: [BackgroundDecorationStyle.bottomRight],
      route: IntroductoryVideoScreen.route,
      body: Stack(
        children: <Widget>[
          Center(child: AppLoading()),
          if (this.introductoryVideo != null)
            BackgroundVideo(
              controller: VideoPlayerController.network(
                this.introductoryVideo!.video.url,
              ),
            ),
        ],
      ),
    );
  }
}
