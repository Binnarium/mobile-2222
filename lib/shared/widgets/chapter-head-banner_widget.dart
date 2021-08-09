import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/models/city.dto.dart';

import 'chapter-leaf-logo_widget.dart';
import 'city-stage.widget.dart';

class ChapterHeadWidget extends StatelessWidget {
  final bool showAppLogo;
  final bool showStageLogo;
  final CityDto city;

  const ChapterHeadWidget({
    this.showAppLogo = false,
    this.showStageLogo = false,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (this.showAppLogo) ChapterLeafLogoWidget(),

        /// added a container in the middle, so that in the event of any of
        /// the components is not enabled, it gets pushed to the right side using
        /// the property of colum space between
        Container(),

        if (this.showStageLogo)
          Flexible(
            child: Container(
              margin: EdgeInsets.only(right: size.width * 0.05),
              child: CityStageWidget(
                cityDto: this.city,
              ),
            ),
          ),
      ],
    );
  }
}
