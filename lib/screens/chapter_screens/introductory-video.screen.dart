import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city-introductory-video.dto.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/services/load-city-introductory-video.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/background-video.widget.dart';
import 'package:lab_movil_2222/shared/widgets/scaffold-2222.widget.dart';
import 'package:video_player/video_player.dart';

class IntroductoryVideoScreen extends StatefulWidget {
  static const String route = '/introductory-video';

  final CityDto city;

  final ILoadOptions<CityIntroductoryVideoDto, CityDto> introductoryVideoLoader;

  IntroductoryVideoScreen({
    Key? key,
    required CityDto city,
  })  : this.city = city,
        this.introductoryVideoLoader = LoadCityIntroductoryVideo(city: city),
        super(key: key);

  @override
  _IntroductoryVideoScreenState createState() =>
      _IntroductoryVideoScreenState();
}

class _IntroductoryVideoScreenState extends State<IntroductoryVideoScreen> {
  CityIntroductoryVideoDto? introductoryVideo;

  @override
  void initState() {
    super.initState();
    this
        .widget
        .introductoryVideoLoader
        .load()
        .then((value) => this.setState(() => this.introductoryVideo = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2222(
      city: this.widget.city,
      backgrounds: [BackgroundDecoration.bottomRight],
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
