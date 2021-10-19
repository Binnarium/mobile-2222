import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/player/models/course-status.enum.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/current-player.service.dart';
import 'package:lab_movil_2222/player/ui/screens/profile.screen.dart';
import 'package:lab_movil_2222/shared/widgets/fade-in-delayed.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/services/cities-navigation.service.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class CityMapButton extends StatelessWidget {
  const CityMapButton({
    Key? key,
    required this.city,
    required this.size,
    required this.textOnTop,
    required this.fadeInDelay,
  }) : super(key: key);

  final CityModel city;
  final double size;
  final bool textOnTop;
  final Duration fadeInDelay;

  @override
  Widget build(BuildContext context) {
    final Size fontFactor = MediaQuery.of(context).size;
    final bool smallFont = fontFactor.width < 750;
    final configuration = createLocalImageConfiguration(context);

    final TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: size,
      height: size,
      child: FadeInDelayed(
        delay: fadeInDelay,
        child: Stack(
          clipBehavior: Clip.none,

          /// make text go on top of image by placing it on top of image container
          children: [
            /// placeholder color
            Positioned.fill(
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.all(Radius.circular(size)),
                child: Container(
                  color: Colors2222.mapColor,
                ),
              ),
            ),

            /// position the image first so the inkwell effect stay on top
            Positioned.fill(
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.all(Radius.circular(size)),
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(city.iconMap.url)..resolve(configuration),
                  width: double.infinity,
                  height: double.infinity,
                  fadeInDuration: const Duration(milliseconds: 500),
                ),
              ),
            ),

            /// inkwell with on press gesture detector, with a clip on top so it stays
            /// in a circular shape
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(size)),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: city.color.withOpacity(0.5),
                  onTap: () => _accessCourse(context),
                  child: Container(),
                ),
              ),
            ),

            /// city name with the city number, to position the item bellow or
            /// on top of the main image, we use the size of the container, plus 8 units
            /// for spacing
            Positioned(
              top: !textOnTop ? size + (smallFont ? 4 : 8) : null,
              bottom: textOnTop ? size + (smallFont ? 4 : 8) : null,
              left: -size,
              right: -size,
              child: Center(
                child: Text(
                  '${city.stage}. ${city.name.toUpperCase()}',
                  style: smallFont ? textTheme.button : textTheme.headline5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// when postulants has access let them access to the city
  /// otherwise show them a explanation of what to do
  /// or where to check their results
  void _accessCourse(BuildContext context) {
    final CurrentPlayerService _playerService =
        Provider.of<CurrentPlayerService>(context, listen: false);
    final PlayerModel? currentPlayer = _playerService.currentPlayer;

    /// let them in
    if ([
      CourseStatus.inProgress,
      CourseStatus.approvedContinueNextPhaseWithContentAccess
    ].contains(currentPlayer?.courseStatus)) {
      final route = CityNavigator.getFirsScreenOfCity(city);
      route.builder(context);
      return;
    }

    /// show them course has not started yet
    if (currentPlayer?.courseStatus == CourseStatus.notStarted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El viaje aún no ha comenzado.'),
        ),
      );
      return;
    }

    /// course has concluded
    if ([
      CourseStatus.notApproved,
      CourseStatus.approvedCanContinueNextPhaseNoContentAccess,
      CourseStatus.approvedCanNotContinueNextPhase,
    ].contains(currentPlayer?.courseStatus)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'El viaje ha finalizado, accede a tus resultados en tu perfil.',
          ),
          action: SnackBarAction(
            label: 'Mi viaje al día',
            onPressed: () =>
                Navigator.pushReplacementNamed(context, ProfileScreen.route),
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Necesitas actualizar tu aplicación.'),
      ),
    );
  }
}
