import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/background-video.widget.dart';
import 'package:lab_movil_2222/cities/project-video/model/city-project-video.model.dart';
import 'package:lab_movil_2222/cities/project-video/services/load-project-video.service.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class ProjectVideoScreen extends StatefulWidget {
  const ProjectVideoScreen({
    Key? key,
    required CityModel city,
  })  : city = city,
        super(key: key);

  static const String route = '/project-video';

  final CityModel city;

  @override
  _ProjectVideoScreenState createState() => _ProjectVideoScreenState();
}

class _ProjectVideoScreenState extends State<ProjectVideoScreen> {
  CityProjectVideoModel? projectVideo;
  StreamSubscription? _loadProjectVideoSub;

  @override
  void initState() {
    super.initState();

    final LoadProjectVideoService loadProjectVideoService =
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
      backgrounds: const [BackgroundDecorationStyle.bottomRight],
      route: ProjectVideoScreen.route,
      body: Stack(
        children: <Widget>[
          /// loading state
          const Center(child: AppLoading()),

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
