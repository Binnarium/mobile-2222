import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/services/cities-navigation.service.dart';

class CityMapButton extends StatelessWidget {
  final CityModel city;
  final double size;
  final bool textOnTop;

  const CityMapButton({
    Key? key,
    required this.city,
    required this.size,
    required this.textOnTop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size fontFactor = MediaQuery.of(context).size;
    final bool smallFont = fontFactor.width < 750;

    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      width: this.size,
      height: this.size,
      child: Stack(
        clipBehavior: Clip.none,

        /// make text go on top of image by placing it on top of image container
        children: [
          /// placeholder color
          Positioned.fill(
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.all(Radius.circular(this.size)),
              child: Container(
                color: Colors2222.mapColor,
              ),
            ),
          ),

          /// position the image first so the inkwell effect stay on top
          Positioned.fill(
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.all(Radius.circular(this.size)),
              child: Image(
                image: this.city.iconMapImage,
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
              borderRadius: BorderRadius.all(Radius.circular(this.size)),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: this.city.color.withOpacity(0.5),
                onTap: () {
                  final route = CityNavigator.getFirsScreenOfCity(this.city);
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
            top: !this.textOnTop ? this.size + (smallFont ? 4 : 8) : null,
            bottom: this.textOnTop ? this.size + (smallFont ? 4 : 8) : null,
            left: -this.size,
            right: -this.size,
            child: Center(
              child: Text(
                '${this.city.stage}. ${this.city.name.toUpperCase()}',
                style: smallFont ? textTheme.button : textTheme.headline5,
              ),
            ),
          )
        ],
      ),
    );
  }
}
