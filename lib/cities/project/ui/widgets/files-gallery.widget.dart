import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lab_movil_2222/cities/project/models/player-projects.model.dart';
import 'package:lab_movil_2222/cities/project/services/load-project-files.service.dart';
import 'package:lab_movil_2222/cities/project/ui/widgets/project-file-card.widget.dart';
import 'package:lab_movil_2222/home-map/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:provider/provider.dart';

class FilesGalleryWidget extends StatefulWidget {
  /// constructor
  const FilesGalleryWidget({
    Key? key,
    required this.city,
  }) : super(key: key);

  final CityModel city;

  @override
  _FilesGalleryWidgetState createState() => _FilesGalleryWidgetState();
}

class _FilesGalleryWidgetState extends State<FilesGalleryWidget> {
  /// projects uploaded by the player
  List<PlayerProject>? projectFiles;

  /// user projects loader
  StreamSubscription? _userProjectsSub;

  LoadProjectFiles get loadProjectFiles =>
      Provider.of<LoadProjectFiles>(context, listen: false);

  @override
  void initState() {
    super.initState();

    /// stream of projects
    _userProjectsSub = loadProjectFiles.load$(widget.city).listen(
      (projects) {
        if (mounted) {
          setState(() {
            projectFiles = projects;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _userProjectsSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    /// loading project files
    if (projectFiles == null) return const AppLoading();

    /// no files uploaded yet
    if (projectFiles!.isEmpty)
      return Column(
        children: [
          /// default image
          Image.asset(
            'assets/images/empty-projects.png',
            width: min(size.width * 0.3, 400),
          ),

          /// spacer
          const SizedBox(height: 18),

          /// no files yet text
          Text(
            'Aún no tienes ningún archivo',
            style: textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ],
      );

    /// grid with uploaded files
    return StaggeredGridView.countBuilder(
      crossAxisCount: 3,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      itemCount: projectFiles!.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => ProjectFileCardWidget(
        projectFile: projectFiles![index],
        cityModel: widget.city,
      ),
    );
  }
}
