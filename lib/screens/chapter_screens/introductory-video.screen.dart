import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/models/city-introductory-video.dto.dart';
import 'package:lab_movil_2222/services/load-city-introductory-video.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/background-video.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class IntroductoryVideoScreen extends StatefulWidget {
  const IntroductoryVideoScreen({
    Key? key,
    required CityModel city,
  })  : city = city,
        super(key: key);

  static const String route = '/introductory-video';

  final CityModel city;

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

    final LoadCityIntroductoryVideoService loadIntroductoryVideoService =
        Provider.of<LoadCityIntroductoryVideoService>(context, listen: false);

    _loadIntroductoryVideoSub =
        loadIntroductoryVideoService.load$(widget.city).listen(
      (introductoryVideoDto) {
        if (mounted) {
          setState(() {
            introductoryVideo = introductoryVideoDto;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _loadIntroductoryVideoSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2222.city(
      city: widget.city,
      // ignore: prefer_const_literals_to_create_immutables
      backgrounds: [BackgroundDecorationStyle.bottomRight],
      route: IntroductoryVideoScreen.route,
      body: Stack(
        children: <Widget>[
          const Center(child: AppLoading()),
          if (introductoryVideo != null)
            BackgroundVideo(
              controller: VideoPlayerController.network(
                introductoryVideo!.video.url,
              ),
            ),
        ],
      ),
    );
  }
}
