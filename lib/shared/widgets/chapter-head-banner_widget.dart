import 'package:flutter/material.dart';

import 'chapter-banner_widget.dart';
import 'chapter-leaf-logo_widget.dart';

class ChapterHeadWidget extends StatelessWidget {
  final String phaseName;
  final String chapterName;
  final String chapterImgURL;
  const ChapterHeadWidget({
    required this.phaseName,
    required this.chapterName,
    required this.chapterImgURL,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        ChapterLeafLogoWidget(),
        ChapterBannerWidget(
          phase: phaseName,
          chapterName: chapterName,
          chapterImgURL: this.chapterImgURL,
        ),
      ],
    );
  }
}
