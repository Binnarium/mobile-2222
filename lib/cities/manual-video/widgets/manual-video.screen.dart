import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/background-video.widget.dart';
import 'package:lab_movil_2222/cities/manual-video/model/city-manual-video.model.dart';
import 'package:lab_movil_2222/cities/manual-video/services/load-manual-video.service.dart';
import 'package:lab_movil_2222/home-map/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class ManualVideoScreen extends StatefulWidget {
  const ManualVideoScreen({
    Key? key,
    required CityModel cityModel,
  })  : city = cityModel,
        super(key: key);

  static const String route = '/manual-video';

  final CityModel city;

  @override
  _ManualVideoScreenState createState() => _ManualVideoScreenState();
}

class _ManualVideoScreenState extends State<ManualVideoScreen> {
  CityManualVideoModel? manualVideo;
  StreamSubscription? _loadManualVideoSub;

  @override
  void initState() {
    super.initState();

    final LoadManualVideoService loadManualVideoService =
        Provider.of<LoadManualVideoService>(context, listen: false);

    _loadManualVideoSub = loadManualVideoService.load$(widget.city).listen(
      (manualVideoModel) {
        if (mounted) {
          setState(() {
            manualVideo = manualVideoModel;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _loadManualVideoSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2222.city(
      city: widget.city,
      backgrounds: const [BackgroundDecorationStyle.bottomRight],
      route: ManualVideoScreen.route,
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
              onPress: () => launch(manualVideo!.link),
            ),
        ],
      ),
    );
  }
}
