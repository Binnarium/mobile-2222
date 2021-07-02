import 'package:flutter/material.dart';

import 'chapter-banner_widget.dart';
import 'chapter-leaf-logo_widget.dart';

class ChapterHeadWidget extends StatelessWidget {
  final String phaseName;
  final String? chapterName;
  final String? chapterImgURL;
  const ChapterHeadWidget({
    required this.phaseName,
    this.chapterName,
    this.chapterImgURL,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        ChapterLeafLogoWidget(),

        /// to check if the page is the introduction page, so we can't show
        /// the banner widget.
        (phaseName.compareTo('introduction') != 0)
            ? ChapterBannerWidget(
                phase: this.phaseName,
                chapterName: this.chapterName!,
                chapterImgURL: this.chapterImgURL!,
              )
            : Container(),
      ],
    );
  }
}
