import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/background-video.widget.dart';
import 'package:lab_movil_2222/authentication/authentication-home/authentication-home.screen.dart';
import 'package:lab_movil_2222/authentication/start-video/load-start-video.service.dart';
import 'package:lab_movil_2222/authentication/start-video/start-video.model.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class StartVideoScreen extends StatefulWidget {
  const StartVideoScreen({
    Key? key,
  }) : super(key: key);

  static const String route = '/start-video';

  @override
  _StartVideoScreenState createState() => _StartVideoScreenState();
}

class _StartVideoScreenState extends State<StartVideoScreen> {
  StartVideoModel? startVideo;

  StreamSubscription? _loadStartVideoModel;

  @override
  void initState() {
    super.initState();

    final LoadStartVideoService loadStartVideoService =
        Provider.of<LoadStartVideoService>(context, listen: false);

    _loadStartVideoModel = loadStartVideoService.load$().listen(
      (startVideoModel) {
        if (mounted) {
          setState(() {
            startVideo = startVideoModel;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _loadStartVideoModel?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2222.empty(
      body: Stack(
        children: <Widget>[
          /// loading state
          const Center(child: AppLoading()),

          /// background video
          if (startVideo != null)
            BackgroundVideo(
              controller: VideoPlayerController.network(
                startVideo!.video.url,
              ),
              lopping: false,
              onComplete: () => navigateNextPage(context),
              onPress: () => navigateNextPage(context),
            ),
        ],
      ),
    );
  }

  void navigateNextPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, AuthenticationHomeScreen.route);
  }
}
