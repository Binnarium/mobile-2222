import 'package:flutter/material.dart';

import 'chapter-banner_widget.dart';
import 'chapter-leaf-logo_widget.dart';

class ChapterHeadWidget extends StatelessWidget {
  final String phaseName;
  final String chapterName;
  const ChapterHeadWidget({
    required this.phaseName,
    required this.chapterName,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(right: size.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ChapterLeafLogoWidget(),
          ChapterBannerWidget(phase: phaseName, chapterName: chapterName),
        ],
      ),
    );
  }
}
