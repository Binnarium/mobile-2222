import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
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
        Provider.of<LoadStartVideoService>(this.context, listen: false);

    this._loadStartVideoModel = loadStartVideoService.load$().listen(
      (startVideoModel) {
        if (this.mounted)
          this.setState(() {
            this.startVideo = startVideoModel;
          });
      },
    );
  }

  @override
  void dispose() {
    this._loadStartVideoModel?.cancel();
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
          if (this.startVideo != null)
            BackgroundVideo(
              controller: VideoPlayerController.network(
                this.startVideo!.video.url,
              ),
              lopping: false,
              onComplete: () => this.navigateNextPage(context),
              onPressed: () => this.navigateNextPage(context),
            ),
        ],
      ),
    );
  }

  void navigateNextPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginScreen.route);
  }
}
