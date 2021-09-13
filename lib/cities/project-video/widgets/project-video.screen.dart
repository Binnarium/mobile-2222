import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/project-video/model/city-project-video.model.dart';
import 'package:lab_movil_2222/cities/project-video/services/load-project-video.service.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/background-video.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class ProjectVideoScreen extends StatefulWidget {
  static const String route = '/project-video';

  final CityDto city;

  ProjectVideoScreen({
    Key? key,
    required CityDto city,
  })  : this.city = city,
        super(key: key);

  @override
  _ProjectVideoScreenState createState() => _ProjectVideoScreenState();
}

class _ProjectVideoScreenState extends State<ProjectVideoScreen> {
  CityProjectVideoModel? projectVideo;
  StreamSubscription? _loadProjectVideoSub;

  @override
  void initState() {
    super.initState();

    LoadProjectVideoService loadProjectVideoService =
        Provider.of<LoadProjectVideoService>(this.context, listen: false);

    this._loadProjectVideoSub =
        loadProjectVideoService.load$(this.widget.city).listen(
      (projectVideoModel) {
        if (this.mounted)
          this.setState(() {
            this.projectVideo = projectVideoModel;
          });
      },
    );
  }

  @override
  void dispose() {
    this._loadProjectVideoSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2222.city(
      city: this.widget.city,
      backgrounds: [BackgroundDecorationStyle.bottomRight],
      route: ProjectVideoScreen.route,
      body: Stack(
        children: <Widget>[
          /// loading state
          Center(child: AppLoading()),

          /// background video
          if (this.projectVideo != null)
            BackgroundVideo(
              controller: VideoPlayerController.network(
                this.projectVideo!.video.url,
              ),
            ),
        ],
      ),
    );
  }
}
