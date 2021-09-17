import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/project-video/model/city-project-video.model.dart';
import 'package:lab_movil_2222/cities/project-video/services/load-project-video.service.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/background-video.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class ProjectVideoScreen extends StatefulWidget {
  static const String route = '/project-video';

  final CityModel city;

  ProjectVideoScreen({
    Key? key,
    required CityModel city,
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
        Provider.of<LoadProjectVideoService>(context, listen: false);

    _loadProjectVideoSub = loadProjectVideoService.load$(widget.city).listen(
      (projectVideoModel) {
        if (mounted) {
          setState(() {
            projectVideo = projectVideoModel;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _loadProjectVideoSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2222.city(
      city: widget.city,
      backgrounds: [BackgroundDecorationStyle.bottomRight],
      route: ProjectVideoScreen.route,
      body: Stack(
        children: <Widget>[
          /// loading state
          Center(child: AppLoading()),

          /// background video
          if (projectVideo != null)
            BackgroundVideo(
              controller: VideoPlayerController.network(
                projectVideo!.video.url,
              ),
            ),
        ],
      ),
    );
  }
}
