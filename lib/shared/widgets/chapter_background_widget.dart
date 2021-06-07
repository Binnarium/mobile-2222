import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/background_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ChapterBackgroundWidget extends StatelessWidget {
  final Color backgroundColor;
  final Container? relieve;
  final bool? hasBanner;

  ChapterBackgroundWidget(
      {required this.backgroundColor, this.relieve, this.hasBanner});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        children: [
          BackgroundWidget(backgroundColor: ColorsApp.backgroundOrange),
          _relieve(),
          _logoLeaf(size),
          _banner(size, context),
        ],
      ),
    );
  }

  _logoLeaf(Size size) {
    return Container(
      alignment: Alignment.topLeft,
      width: size.width * 0.2,
      height: size.height * 0.18,
      child: Image(
        image: AssetImage(
          'assets/backgrounds/decorations/logo_leaf.png',
        ),
      ),
    );
  }

  _relieve() {
    if (relieve == null) {
      return Container();
    } else {
      return relieve;
    }
  }

  _banner(Size size, BuildContext context) {
    double bannerContainerWidth = size.width * 0.6;
    double bannerContainerHeight = size.height * 0.12;
    if (hasBanner == null) {
      return Container();
    } else {
      return Positioned(
        right: size.width * 0.05,
        top: size.height * 0.03,
        child: Container(
          width: bannerContainerWidth,
          height: bannerContainerHeight,
          child: Stack(
            children: [
              _logoContainer(bannerContainerWidth, bannerContainerHeight),
              _numberStage(bannerContainerWidth, bannerContainerHeight),
              _titleStage(bannerContainerWidth, bannerContainerHeight),
            ],
          ),
        ),
      );
    }
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
        child: Text('ETAPA 4',
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
        child: Text('AZTLÁN',
            style: korolevFont.headline6?.apply(fontSizeFactor: 1.5),
            textAlign: TextAlign.right),
      ),
    );
  }
}
