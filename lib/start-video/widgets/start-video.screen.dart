import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/background-video.widget.dart';
import 'package:lab_movil_2222/start-video/model/start-video.model.dart';
import 'package:lab_movil_2222/start-video/services/load-start-video.service.dart';
import 'package:lab_movil_2222/user/widgets/login.screen.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class StartVideoScreen extends StatefulWidget {
  static const String route = '/start-video';

  StartVideoScreen({
    Key? key,
  }) : super(key: key);

  @override
  _StartVideoScreenState createState() => _StartVideoScreenState();
}

class _StartVideoScreenState extends State<StartVideoScreen> {
  StartVideoModel? startVideo;

  StreamSubscription? _loadStartVideoModel;

  @override
  void initState() {
    super.initState();

    LoadStartVideoService loadStartVideoService =
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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          /// loading state
          Center(child: AppLoading()),

          /// background video
          if (startVideo != null)
            BackgroundVideo(
              controller: VideoPlayerController.network(
                startVideo!.video.url,
              ),
              lopping: false,
              onComplete: () => navigateNextPage(context),
              onPressed: () => navigateNextPage(context),
            ),
        ],
      ),
    );
  }

  void navigateNextPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginScreen.route);
  }
}
