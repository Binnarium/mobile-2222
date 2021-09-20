import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/services/cities-navigation.service.dart';

class CityMapButton extends StatelessWidget {
  const CityMapButton({
    Key? key,
    required this.city,
    required this.size,
    required this.textOnTop,
  }) : super(key: key);

  final CityModel city;
  final double size;
  final bool textOnTop;

  @override
  Widget build(BuildContext context) {
    final Size fontFactor = MediaQuery.of(context).size;
    final bool smallFont = fontFactor.width < 750;

    final TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: size,
      height: size,
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
              child: Image(
                image: city.iconMapImage,
                width: double.infinity,
                height: double.infinity,
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
                onTap: () {
                  final route = CityNavigator.getFirsScreenOfCity(city);
                  route.builder(context);
                },
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
    );
  }
}
