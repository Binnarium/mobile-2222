import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lab_movil_2222/cities/project/models/player-projects.model.dart';
import 'package:lab_movil_2222/cities/project/services/upload-project.service.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/buttonDialog.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectGalleryWidget extends StatefulWidget {
  final CityModel city;
  final String userUID;
  final List<PlayerProject> projects;
  // ignore: sort_constructors_first
  const ProjectGalleryWidget({
    Key? key,
    required this.city,
    required this.userUID,
    required this.projects,
  }) : super(key: key);

  @override
  _ProjectGalleryWidgetState createState() => _ProjectGalleryWidgetState();
}

class _ProjectGalleryWidgetState extends State<ProjectGalleryWidget> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final List<PlayerProject> cityProjects = [];
    List<Widget> items = [];
    // ignore: avoid_function_literals_in_foreach_calls
    widget.projects.forEach((element) {
      // print(element.cityName);
      if (element.cityID == widget.city.name) {
        cityProjects.add(element);
      }
      // print("PROJECT: $project");
    });
    if (cityProjects != <dynamic>[]) {
      items = _gridItemsList(cityProjects);
    }
    return Column(
      children: [
        if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/empty-projects.png',
                  width: size.width * 0.3,
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  'Aún no tienes ningún proyecto',
                  style: textTheme.headline5?.apply(fontSizeFactor: 0.8),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        else
          StaggeredGridView.countBuilder(
            crossAxisCount: 3,
            staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
            itemCount: items.length,
            padding: const EdgeInsets.all(12),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            mainAxisSpacing: 16,
            crossAxisSpacing: 10,
            itemBuilder: (context, index) {
              final item = items.elementAt(index);
              return item;
            },
          ),
      ],
    );
  }

  List<Widget> _gridItemsList(List<PlayerProject> projects) {
    final List<Widget> items = [];
    // ignore: avoid_function_literals_in_foreach_calls
    projects.forEach((project) {
      if (project.cityID == widget.city.name) {
        items.add(_gridItem(project));
      }
    });
    return items;
  }

  Material _gridItem(PlayerProject project) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () async {
          return showDialog(
              context: context,
              builder: (context) {
                return fileDialog(project);
              });
        },
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 10,
          children: [
            Image.asset('assets/icons/upload_project_icon.png'),
            Text(project.file.path.split('/').last)
          ],
        ),
      ),
    );
  }

  AlertDialog fileDialog(PlayerProject project) {
    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: Text(project.file.path.split('/').last),
              ),
            ),
            ButtonWidget(
              color: widget.city.color,
              icon: Icons.download_rounded,
              text: 'Descargar',
              iconColor: Colors.white,
              onClicked: () {
                launch(project.file.url);
              },
            ),
            ButtonWidget(
              color: Colors2222.red,
              icon: Icons.delete_rounded,
              iconColor: Colors.white,
              text: 'Eliminar',
              onClicked: () {
                UploadProjectService.deletePlayerProjectFile(
                    widget.userUID, project);
                setState(() {});
                Navigator.pop(context);
              },
            )
          ]),
    );
  }
}
