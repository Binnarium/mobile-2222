import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/audio/ui/audio-player.widget.dart';
import 'package:lab_movil_2222/cities/project/models/project-activity.model.dart';
import 'package:lab_movil_2222/cities/project/ui/widgets/coins_check.widget.dart';
import 'package:lab_movil_2222/cities/project/ui/widgets/files-gallery.widget.dart';
import 'package:lab_movil_2222/cities/project/ui/widgets/upload-file-button.widget.dart';
import 'package:lab_movil_2222/home-map/models/city.dto.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/player/services/current-player.service.dart';
import 'package:lab_movil_2222/services/load-project-activity.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class CityProjectScreen extends StatefulWidget {
  const CityProjectScreen({
    Key? key,
    required this.city,
  }) : super(key: key);

  static const String route = '/project';

  final CityModel city;

  @override
  _CityProjectScreenState createState() => _CityProjectScreenState();
}

class _CityProjectScreenState extends State<CityProjectScreen> {
  /// project screen information
  ProjectActivityModel? projectScreen;

  /// user information loader
  StreamSubscription? _userServiceSub;

  StreamSubscription? _loadProjectDtoSub;

  bool hasMedal = false;

  CurrentPlayerService get _currentPlayerService =>
      Provider.of<CurrentPlayerService>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _userServiceSub = _currentPlayerService.player$.listen((player) {
      if (mounted) {
        setState(() {
          /// seeks for all medals in the medals array
          player!.projectAwards.asMap().forEach((key, value) {
            if (value.cityId == widget.city.id) hasMedal = true;
          });
        });
      }
    });

    /// load the provider to load the projectDTO
    final LoadProjectDtoService loadProjectDtoService =
        Provider.of<LoadProjectDtoService>(context, listen: false);

    /// calls the service to load the projectDTO
    _loadProjectDtoSub = loadProjectDtoService.load$(widget.city).listen(
      (projectDto) {
        if (mounted) {
          setState(() {
            projectScreen = projectDto;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _userServiceSub?.cancel();
    _loadProjectDtoSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final horizontalPadding =
        EdgeInsets.symmetric(horizontal: size.width * 0.08);

    return Scaffold2222.city(
      city: widget.city,
      backgrounds: const [
        BackgroundDecorationStyle.topRight,
        BackgroundDecorationStyle.path
      ],
      route: CityProjectScreen.route,
      body: ListView(
        children: [
          /// icon item
          LogosHeader(
            showStageLogoCity: widget.city,
          ),

          /// spacer
          const SizedBox(height: 32),

          Center(
            child: SizedBox(
              width: min(300, size.width * 0.9),
              child: Text(
                'PROYECTO DOCENTE'.toUpperCase(),
                style: textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
          ),

          /// spacer
          const SizedBox(height: 24),

          Center(
            child: CoinsCheckWidget(
              coin: const MedalImage.project(),
              hasMedal: hasMedal,
            ),
          ),

          /// spacer
          const SizedBox(height: 32),

          ///
          if (projectScreen == null)
            const AppLoading()
          else ...[
            Padding(
              padding: horizontalPadding,
              child: Text(
                projectScreen!.activity,
                style: textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            /// spacer
            const SizedBox(height: 28),

            ///
            Padding(
              padding: horizontalPadding,
              child: Markdown2222(
                data: projectScreen!.explanation,
                contentAlignment: WrapAlignment.start,
              ),
            ),

            /// spacer
            const SizedBox(height: 20),

            /// if audio is available then show the audio player
            if (projectScreen!.audio != null) ...[
              Container(
                alignment: Alignment.center,
                padding: horizontalPadding,
                child: AudioPlayerWidget(
                  audio: projectScreen!.audio!,
                  color: widget.city.color,
                ),
              ),

              /// spacer
              const SizedBox(height: 32),
            ],

            /// upload file couldn't be found
            if (projectScreen!.allowed == ProjectFileAllowed.NOT_IMPLEMENTED)
              const Text('Actualiza tu aplicación')

            /// allow video or audio file
            else if ([ProjectFileAllowed.AUDIO, ProjectFileAllowed.PDF]
                .contains(projectScreen!.allowed)) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: FilesGalleryWidget(
                  city: widget.city,
                ),
              ),

              /// spacer
              const SizedBox(height: 16),

              ///
              Padding(
                padding: horizontalPadding,
                child: UploadFileButton(
                  city: widget.city,
                  projectFileAllowed: projectScreen!.allowed,
                ),
              ),

              /// spacer
              const SizedBox(height: 40),
            ],
          ],
        ],
      ),
    );
  }
}
