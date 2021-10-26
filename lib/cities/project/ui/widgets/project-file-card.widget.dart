import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/project/models/player-projects.model.dart';
import 'package:lab_movil_2222/cities/project/services/upload-project.service.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectFileCardWidget extends StatelessWidget {
  const ProjectFileCardWidget({
    Key? key,
    required this.projectFile,
    required this.cityModel,
  }) : super(key: key);

  /// file to be displayed
  final PlayerProject projectFile;

  /// reference to city to theme with the city color
  final CityModel cityModel;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () async {
          return showDialog(
              context: context,
              builder: (context) {
                return fileDialog(context);
              });
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Image.asset('assets/icons/upload_project_icon.png'),
              Text(projectFile.file.path.split('/').last)
            ],
          ),
        ),
      ),
    );
  }

  AlertDialog fileDialog(BuildContext context) {
    final UploadProjectService uploadProjectService =
        Provider.of<UploadProjectService>(context, listen: false);

    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: Text(projectFile.file.path.split('/').last),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: cityModel.color,
              onPrimary: Colors2222.white,
            ),
            icon: const Icon(Icons.download_rounded),
            label: const Text('Descargar'),
            onPressed: () {
              launch(projectFile.file.url);
            },
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors2222.red,
              onPrimary: Colors2222.white,
            ),
            icon: const Icon(Icons.delete_rounded),
            label: const Text('Eliminar'),
            onPressed: () async {
              try {
                await uploadProjectService.deletePlayerProjectFile(projectFile);
                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ocurrio un error al eliminar el archivo.'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
