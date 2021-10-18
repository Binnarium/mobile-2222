import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/background-video.widget.dart';
import 'package:lab_movil_2222/cities/final-video/model/city-final-video.model.dart';
import 'package:lab_movil_2222/cities/final-video/services/load-final-video.service.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class FinalVideoScreen extends StatefulWidget {
  const FinalVideoScreen({
    Key? key,
    required CityModel cityModel,
  })  : city = cityModel,
        super(key: key);

  static const String route = '/final-video';

  final CityModel city;

  @override
  _FinalVideoScreenState createState() => _FinalVideoScreenState();
}

class _FinalVideoScreenState extends State<FinalVideoScreen> {
  CityFinalVideoModel? manualVideo;
  StreamSubscription? _loadFinalVideoSub;

  @override
  void initState() {
    super.initState();

    final LoadFinalVideoService loadFinalVideoService =
        Provider.of<LoadFinalVideoService>(context, listen: false);

    _loadFinalVideoSub = loadFinalVideoService.load$(widget.city).listen(
      (finalVideoModel) {
        if (mounted) {
          setState(() {
            manualVideo = finalVideoModel;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _loadFinalVideoSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2222.city(
      city: widget.city,
      backgrounds: const [BackgroundDecorationStyle.bottomRight],
      route: FinalVideoScreen.route,
      body: Stack(
        children: <Widget>[
          /// loading state
          const Center(child: AppLoading()),

          /// background video
          if (manualVideo != null)
            BackgroundVideo(
              controller: VideoPlayerController.network(
                manualVideo!.video.url,
              ),
            ),
        ],
      ),
    );
  }
}
