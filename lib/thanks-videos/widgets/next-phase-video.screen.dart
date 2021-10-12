import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/background-video.widget.dart';
import 'package:lab_movil_2222/thanks-videos/model/city-thanks-video.model.dart';
import 'package:lab_movil_2222/thanks-videos/services/load-thanks-video.service.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class NextPhaseVideoScreen extends StatefulWidget {
  const NextPhaseVideoScreen({
    Key? key,
    required CityModel city,
  })  : city = city,
        super(key: key);

  static const String route = '/next-phase-video';

  final CityModel city;

  @override
  _NextPhaseVideoScreenState createState() => _NextPhaseVideoScreenState();
}

class _NextPhaseVideoScreenState extends State<NextPhaseVideoScreen> {
  CityThanksVideoModel? thanksVideo;
  StreamSubscription? _loadThanksVideoSub;

  @override
  void initState() {
    super.initState();

    final LoadThanksVideoService loadThanksVideoService =
        Provider.of<LoadThanksVideoService>(context, listen: false);

    _loadThanksVideoSub = loadThanksVideoService.load$(widget.city).listen(
      (thanksVideoModel) {
        if (mounted) {
          setState(() {
            thanksVideo = thanksVideoModel;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _loadThanksVideoSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2222.city(
      city: widget.city,
      // ignore: prefer_const_literals_to_create_immutables
      backgrounds: [BackgroundDecorationStyle.bottomRight],
      route: NextPhaseVideoScreen.route,
      body: Stack(
        children: <Widget>[
          /// loading state
          const Center(child: AppLoading()),

          /// background video
          if (thanksVideo != null)
            BackgroundVideo(
              controller: VideoPlayerController.network(
                thanksVideo!.video.url,
              ),
            ),
        ],
      ),
    );
  }
}
