import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';

class LogosHeader extends StatelessWidget {
  const LogosHeader({
    Key? key,
    this.showAppLogo = false,
    this.showStageLogoCity,
  }) : super(key: key);

  final bool showAppLogo;
  final CityModel? showStageLogoCity;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showAppLogo) AppLogo(kind: AppImage.cityLogo),

        /// added a container in the middle, so that in the event of any of
        /// the components is not enabled, it gets pushed to the right side using
        /// the property of colum space between
        Container(),

        /// when a city logo is provided then show the stage logo
        if (showStageLogoCity != null)
          Flexible(
            child: Container(
              margin: EdgeInsets.only(top: 16, right: size.width * 0.04),
              child: _CityStageWidget(cityDto: showStageLogoCity!),
            ),
          ),
      ],
    );
  }
}

class _CityStageWidget extends StatelessWidget {
  const _CityStageWidget({
    Key? key,
    required this.cityDto,
  }) : super(key: key);

  final CityModel cityDto;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final TextTheme textTheme = Theme.of(context).textTheme;

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
              cityDto.phaseName,
              style: textTheme.headline5,
              textAlign: TextAlign.right,
              textScaleFactor: fontSizeFactor,
            ),

            /// city name
            Text(
              cityDto.name.toUpperCase(),
              textAlign: TextAlign.right,
              style: textTheme.headline6,
              textScaleFactor: fontSizeFactor,
            ),
          ],
        ),

        /// space between icon and stage name
        SizedBox(
          width: (size.width > 380) ? 8 : 4,
        ),

        /// city icon
        /// important: images are specked to have a 1:1 aspect ratio, therefore
        /// image size determinate width and height of an image
        Hero(
          tag: cityDto.imageTag,
          child: Image(
            image: cityDto.iconImage,
            width: imageSize,
            height: imageSize,
            fit: BoxFit.contain,
          ),
        )
      ],
    );
  }
}
