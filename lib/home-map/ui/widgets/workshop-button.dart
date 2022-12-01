import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/shared/widgets/fade-in-delayed.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/workshop-medals/ui/screens/workshop-awards.screen.dart';
import 'package:transparent_image/transparent_image.dart';

class WorkshopMapButton extends StatelessWidget {
  const WorkshopMapButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Duration fadeInDelay = Duration(milliseconds: 1900);
    final double size = MediaQuery.of(context).size.width / 100 * 12;
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
                  image: const MedalImage.marathon()..resolve(configuration),
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
                  splashColor: Colors2222.primary.withOpacity(0.5),
                  onTap: () => Navigator.pushNamed(
                    context,
                    WorkshopAwardsScreen.route,
                  ),
                  child: Container(),
                ),
              ),
            ),

            Positioned(
              top: size + (smallFont ? 4 : 8),
              bottom: null,
              left: -size * 1.5,
              right: -size * 1.5,
              child: Center(
                child: Text(
                  'Premiación Taller de Ideación',
                  style: smallFont ? textTheme.button : textTheme.headline5,
                  softWrap: false,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
