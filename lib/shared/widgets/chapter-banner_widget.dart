import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ChapterBannerWidget extends StatelessWidget {
  final String phase;
  final String chapterName;
  final String chapterImgURL;
  const ChapterBannerWidget(
      {required this.phase,
      required this.chapterName,
      required this.chapterImgURL});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return _banner(size, context);
  }

  _banner(Size size, BuildContext context) {
    double bannerContainerWidth = size.width * 0.6;
    double bannerContainerHeight = size.height * 0.099;
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            children: [
              _numberStage(bannerContainerWidth, bannerContainerHeight),
              _titleStage(bannerContainerWidth, bannerContainerHeight),
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
    );
  }

  _logoContainer(double parentWidth, double parentHeight) {
    double containerWidth = parentWidth * 0.33;
    double containerHeight = parentHeight;
    return Container(
      //largo y ancho del logo dentro
      width: containerWidth,
      height: containerHeight,
      // margin: EdgeInsets.only(left: marginLeft, top: marginTop),
      alignment: Alignment.center,
      child: Image(
        image: AssetImage(
          this.chapterImgURL,
        ),
      ),
    );
  }

  _numberStage(double parentWidth, double parentHeight) {
    //Creando el contenedor del numberStage
    double containerWidth = parentWidth * 0.7;
    double containerHeight = parentHeight * 0.3;
    // double fontSize = size.height * 0.00051;

    return Container(
      width: containerWidth,
      height: containerHeight,
      alignment: Alignment.centerRight,
      child: Text(phase.toUpperCase(),
          style: korolevFont.headline5?.apply(fontSizeFactor: 0.7),
          textAlign: TextAlign.left),
    );
  }

  _titleStage(double parentWidth, double parentHeight) {
    //Creando el Scroll
    double containerWidth = parentWidth * 0.7;
    double containerHeight = parentHeight * 0.4;
    double fontSize = (chapterName.length >= 10) ? 1.3 : 1.5;
    return Container(
      width: containerWidth,
      height: containerHeight,
      child: Text(chapterName.toUpperCase(),
          style: korolevFont.headline6?.apply(fontSizeFactor: fontSize),
          textAlign: TextAlign.right),
    );
  }
}
