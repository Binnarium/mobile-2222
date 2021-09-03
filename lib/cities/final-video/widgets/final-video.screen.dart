import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/final-video/model/city-final-video.model.dart';
import 'package:lab_movil_2222/cities/final-video/services/load-final-video.service.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/background-video.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:video_player/video_player.dart';

class FinalVideoScreen extends StatefulWidget {
  static const String route = '/final-video';

  final CityDto city;

  final ILoadOptions<CityFinalVideoModel, CityDto> finalVideoLoader;

  FinalVideoScreen({
    Key? key,
    required CityDto city,
  })  : this.city = city,
        this.finalVideoLoader = LoadFinalVideoService(city: city),
        super(key: key);

  @override
  _FinalVideoScreenState createState() => _FinalVideoScreenState();
}

class _FinalVideoScreenState extends State<FinalVideoScreen> {
  CityFinalVideoModel? manualVideo;

  @override
  void initState() {
    super.initState();
    this
        .widget
        .finalVideoLoader
        .load()
        .then((value) => this.setState(() => this.manualVideo = value));
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
