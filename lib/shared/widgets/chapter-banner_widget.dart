import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ChapterBannerWidget extends StatelessWidget {
  final String phaseName;
  final String chapterName;
  final String chapterImgURL;
  final String imagePath;

  const ChapterBannerWidget({
    required this.phaseName,
    required this.chapterName,
    required this.chapterImgURL,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return _banner(size, context);
  }

  _banner(Size size, BuildContext context) {
    double bannerContainerWidth = size.width * 0.6;
    double bannerContainerHeight = size.height * 0.099;
    return Flexible(
      child: Container(
        // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),

        /// margin in right always in 0.05% of the screen
        margin: EdgeInsets.only(right: size.width * 0.05),
        child: Row(
          /// to take the less space from the container in the row
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _numberStage(),
                _titleStage(),
              ],
            ),
            (size.width > 380)
                ? SizedBox(
                    width: 10,
                  )
                : SizedBox(
                    width: 5,
                  ),
            _logoContainer(bannerContainerWidth, bannerContainerHeight),
          ],
        ),
      ),
    );
  }

  _logoContainer(double parentWidth, double parentHeight) {
    double containerWidth = parentWidth * 0.33;
    print('parentwidth: $parentWidth');
    return Hero(
      tag: this.imagePath,
      child: Image.network(
        this.chapterImgURL,

        /// condition when screen is on landscape
        width: (parentWidth > 350) ? containerWidth * 0.5 : containerWidth,
        fit: BoxFit.contain,
      ),
    );
  }

  _numberStage() {
    return Container(
      child: Text(this.phaseName.toUpperCase(),
          style: korolevFont.headline5?.apply(fontSizeFactor: 0.7),
          textAlign: TextAlign.left),
    );
  }

  _titleStage() {
    double fontSize = (chapterName.length >= 10) ? 1.3 : 1.5;
    return Container(
      child: Text(chapterName.toUpperCase(),
          style: korolevFont.headline6?.apply(fontSizeFactor: fontSize),
          textAlign: TextAlign.right),
    );
  }
}
