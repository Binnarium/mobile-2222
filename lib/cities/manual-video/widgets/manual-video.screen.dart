import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/manual-video/model/city-manual-video.model.dart';
import 'package:lab_movil_2222/cities/manual-video/services/load-manual-video.service.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/background-video.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class ManualVideoScreen extends StatefulWidget {
  static const String route = '/manual-video';

  final CityDto city;

  ManualVideoScreen({
    Key? key,
    required CityDto city,
  })  : this.city = city,
        super(key: key);

  @override
  _ManualVideoScreenState createState() => _ManualVideoScreenState();
}

class _ManualVideoScreenState extends State<ManualVideoScreen> {
  CityManualVideoModel? manualVideo;
  StreamSubscription? _loadManualVideoSub;

  @override
  void initState() {
    super.initState();

    LoadManualVideoService loadManualVideoService =
        Provider.of<LoadManualVideoService>(this.context, listen: false);

    this._loadManualVideoSub =
        loadManualVideoService.load$(this.widget.city).listen(
      (manualVideoModel) {
        if (this.mounted)
          this.setState(() {
            this.manualVideo = manualVideoModel;
          });
      },
    );
  }

  @override
  void dispose() {
    this._loadManualVideoSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2222.city(
      city: this.widget.city,
      backgrounds: [BackgroundDecorationStyle.bottomRight],
      route: ManualVideoScreen.route,
      body: Stack(
        children: <Widget>[
          /// loading state
          Center(child: AppLoading()),

          /// background video
          if (this.manualVideo != null)
            BackgroundVideo(
              controller: VideoPlayerController.network(
                this.manualVideo!.video.url,
              ),
              onPressed: () => launch(this.manualVideo!.link),
            ),
        ],
      ),
    );
  }
}
