import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class CityStageWidget extends StatelessWidget {
  final CityDto cityDto;

  const CityStageWidget({
    Key? key,
    required this.cityDto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final double imageSize = (size.width < 400) ? 60 : 75;
    final double fontSizeFactor = (size.width < 400) ? 0.9 : 1;

    /// first of all the main row of items needs to take the minimal space required
    /// therefore it looks great in small devices
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// main column containing city name and stage
        /// important maintain items aligned to the right (end)
        /// applied style underline none, since it shows a yellow underline
        /// on page transition
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            /// stage of the city
            Text(
              this.cityDto.phaseName,
              style: korolevFont.headline5!
                  .copyWith(decoration: TextDecoration.none),
              textAlign: TextAlign.right,
              textScaleFactor: fontSizeFactor,
            ),

            /// city name
            Text(
              this.cityDto.name.toUpperCase(),
              textAlign: TextAlign.right,
              style: korolevFont.headline6!
                  .copyWith(decoration: TextDecoration.none),
              textScaleFactor: fontSizeFactor,
            ),
          ],
        ),

        /// space between icon and stage name
        SizedBox(
          width: (size.width > 380) ? 10 : 5,
        ),

        /// city icon
        /// important images are specked to have a 1:1 aspect ratio, therefore
        /// image size determinate width and height of an image
        Hero(
          tag: this.cityDto.imageTag,
          child: Image(
            image: this.cityDto.iconImage,
            width: imageSize,
            height: imageSize,
            fit: BoxFit.contain,
          ),
        )
      ],
    );
  }
}
