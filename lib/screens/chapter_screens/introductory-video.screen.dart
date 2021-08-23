import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/models/city-introductory-video.dto.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/services/load-city-introductory-video.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
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
    this
        .widget
        .introductoryVideoLoader
        .load()
        .then((value) => this.setState(() => this.introductoryVideo = value));
    super.initState();
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
            IntroductoryVideoWrapper(video: this.introductoryVideo!.video),
        ],
      ),
    );
  }
}

class IntroductoryVideoWrapper extends StatefulWidget {
  IntroductoryVideoWrapper({
    Key? key,
    required VideoDto video,
  })  : this.controller = VideoPlayerController.network(video.url),
        super(key: key);

  final VideoPlayerController controller;

  @override
  _IntroductoryVideoWrapperState createState() =>
      _IntroductoryVideoWrapperState();
}

class _IntroductoryVideoWrapperState extends State<IntroductoryVideoWrapper> {
  @override
  void initState() {
    super.initState();
    this.widget.controller.initialize().then((value) async {
      await this.widget.controller.setLooping(true);
      await this.widget.controller.setVolume(0);
      await this.widget.controller.play();
      this.setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    this.widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: this.widget.controller.value.size.width,
          height: this.widget.controller.value.size.height,
          child: AnimatedOpacity(
              opacity: this.widget.controller.value.isInitialized ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: VideoPlayer(this.widget.controller)),
        ),
      ),
    );
  }
}
