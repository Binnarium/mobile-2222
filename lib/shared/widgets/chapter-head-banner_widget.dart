import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/models/city.dto.dart';

import 'chapter-banner_widget.dart';
import 'chapter-leaf-logo_widget.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (this.showAppLogo) ChapterLeafLogoWidget(),

        Container(),

        /// to check if the page is the introduction page, so we can't show
        /// the banner widget.
        if (this.showStageLogo)
          ChapterBannerWidget(
            phaseName: this.city.phaseName,
            chapterName: this.city.name,
            chapterImgURL: this.city.icon.url,
          ),
      ],
    );
  }
}
