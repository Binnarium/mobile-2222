import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/final-video/model/city-final-video.model.dart';
import 'package:lab_movil_2222/cities/final-video/services/load-final-video.service.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/background-video.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class FinalVideoScreen extends StatefulWidget {
  static const String route = '/final-video';

  final CityDto city;

  FinalVideoScreen({
    Key? key,
    required CityDto city,
  })  : this.city = city,
        super(key: key);

  @override
  _FinalVideoScreenState createState() => _FinalVideoScreenState();
}

class _FinalVideoScreenState extends State<FinalVideoScreen> {
  CityFinalVideoModel? manualVideo;
  StreamSubscription? _loadManualVideoSub;

  @override
  void initState() {
    super.initState();

    LoadFinalVideoService loadFinalVideoService =
        Provider.of<LoadFinalVideoService>(this.context, listen: false);

    this._loadManualVideoSub =
        loadFinalVideoService.load$(this.widget.city).listen(
      (finalVideoModel) {
        if (this.mounted)
          this.setState(() {
            this.manualVideo = finalVideoModel;
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
      route: FinalVideoScreen.route,
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
            ),
        ],
      ),
    );
  }
}
