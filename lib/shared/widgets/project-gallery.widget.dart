import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/models/player-projects.dto.dart';
import 'package:lab_movil_2222/services/upload-file.service.dart';
import 'package:lab_movil_2222/shared/widgets/buttonDialog.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectGalleryWidget extends StatefulWidget {
  final CityDto city;
  final String userUID;
  final List<PlayerProject> projects;
  const ProjectGalleryWidget(
      {Key? key,
      required this.city,
      required this.userUID,
      required this.projects})
      : super(key: key);

  @override
  _ProjectGalleryWidgetState createState() => _ProjectGalleryWidgetState();
}

class _ProjectGalleryWidgetState extends State<ProjectGalleryWidget> {
  @override
  Widget build(BuildContext context) {
    PlayerProject? project;
    List<Widget> items = [];
    this.widget.projects.forEach((element) {
      // print(element.cityName);
      if (element.cityName == this.widget.city.name) {
        project = element;
      }
      // print("PROJECT: $project");
    });
    if (project != null) {
      items = _gridItemsList(project!);
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: Text(
              'Tus proyectos en ${this.widget.city.name}'.toUpperCase(),
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        (project == null && items.length == 0)
            ? Center(child: Text('Aún no tienes proyectos subidos'))
            : StaggeredGridView.countBuilder(
                crossAxisCount: 3,
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                itemCount: items.length,
                padding: EdgeInsets.all(12),
                physics: NeverScrollableScrollPhysics(),
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

  List<Widget> _gridItemsList(PlayerProject project) {
    List<ProjectFile> files = [];
    List<Widget> items = [];
    if (project.cityName == this.widget.city.name) {
      project.files.forEach((element) {
        files.add(element);
        items.add(_gridItem(element));
      });
    }
    return items;
  }

  Material _gridItem(ProjectFile file) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () async {
          return await showDialog(
              context: context,
              builder: (context) {
                return fileDialog(file);
              });
        },
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 10,
          children: [
            Icon(
              Icons.description_rounded,
              size: 50,
            ),
            Text(file.path.split("/").last)
          ],
        ),
      ),
    );
  }

  fileDialog(ProjectFile file) {
    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: Text(file.path.split("/").last),
              ),
            ),
            ButtonWidget(
              color: this.widget.city.color,
              icon: Icons.download_rounded,
              text: 'Descargar',
              iconColor: Colors.white,
              onClicked: () {
                launch(file.url);
              },
            ),
            ButtonWidget(
              color: Colors2222.red,
              icon: Icons.delete_rounded,
              iconColor: Colors.white,
              text: 'Eliminar',
              onClicked: () {
                UploadFileToFirebaseService.deletePlayerProjectFile(
                    this.widget.userUID,
                    this.widget.city.name,
                    file.path,
                    file);
                setState(() {});
                Navigator.pop(context);
              },
            )
          ]),
    );
  }
}
