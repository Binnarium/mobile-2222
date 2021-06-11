import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ChapterBannerWidget extends StatelessWidget {
  final String phase;
  final String chapterName;
  const ChapterBannerWidget({required this.phase, required this.chapterName});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return _banner(size, context);
  }

  _banner(Size size, BuildContext context) {
    double bannerContainerWidth = size.width * 0.6;
    double bannerContainerHeight = size.height * 0.12;
    return Container(
      width: bannerContainerWidth,
      height: bannerContainerHeight,
      child: Stack(
        children: [
          _logoContainer(bannerContainerWidth, bannerContainerHeight),
          _numberStage(bannerContainerWidth, bannerContainerHeight),
          _titleStage(bannerContainerWidth, bannerContainerHeight),
        ],
      ),
    );
  }

  _logoContainer(double parentWidth, double parentHeight) {
    double containerWidth = parentWidth * 0.35;
    double containerHeight = parentHeight;
    return Positioned(
      right: 0,
      child: Container(
        //largo y ancho del logo dentro
        width: containerWidth,
        height: containerHeight,
        // margin: EdgeInsets.only(left: marginLeft, top: marginTop),
        alignment: Alignment.center,
        child: Image(
          image: AssetImage(
            'assets/backgrounds/decorations/black_icon_container.png',
          ),
        ),
      ),
    );
  }

  _numberStage(double parentWidth, double parentHeight) {
    //Creando el contenedor del numberStage
    double containerWidth = parentWidth * 0.7;
    double containerHeight = parentHeight * 0.3;
    // double fontSize = size.height * 0.00051;

    return Positioned(
      top: parentWidth * 0.05,
      right: parentHeight * 1,
      child: Container(
        width: containerWidth,
        height: containerHeight,
        alignment: Alignment.centerRight,
        child: Text(phase.toUpperCase(),
            style: korolevFont.headline5?.apply(fontSizeFactor: 0.7),
            textAlign: TextAlign.left),
      ),
    );
  }

  _titleStage(double parentWidth, double parentHeight) {
    //Creando el Scroll
    double containerWidth = parentWidth * 0.7;
    double containerHeight = parentHeight * 0.4;

    return Positioned(
      top: parentWidth * 0.15,
      right: parentHeight * 1,
      child: Container(
        width: containerWidth,
        height: containerHeight,
        child: Text(chapterName.toUpperCase(),
            style: korolevFont.headline6?.apply(fontSizeFactor: 1.5),
            textAlign: TextAlign.right),
      ),
    );
  }
}
