import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageIntroduction.screen.dart';
import 'package:lab_movil_2222/shared/models/ChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class StageTitleScreen extends StatelessWidget {
  static const String route = '/title';
  final ChapterSettings chapterSettings;

  const StageTitleScreen({
    Key? key,
    required this.chapterSettings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return StageIntroductionScreen(
          chapterSettings: this.chapterSettings,
        );
      }));
    };

    // Navigator.pushNamed(context, StageIntroductionScreen.route);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          /// left
          if (details.delta.dx > 5) prevPage();

          /// right
          if (details.delta.dx < -5) nextPage();
        },

        /// main content of page
        /// the content includes a background with images, and scroll-able content
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// first layer is the background with road-map
            CustomBackground(
              backgroundColor: Color(int.parse(chapterSettings.primaryColor)),
              backgroundImages: [
                /// pattern background
                Image(
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                  image: AssetImage(
                    'assets/backgrounds/decorations/background_decoration1.png',
                  ),
                ),

                /// path background
                Image(
                  alignment: Alignment.bottomCenter,
                  image: AssetImage(
                    'assets/backgrounds/decorations/white_route_curve_background.png',
                  ),
                  color: Color.fromRGBO(255, 255, 255, 100),
                ),

                /// 2222 logo
                Image(
                  alignment: Alignment.topLeft,
                  image: AssetImage(
                    'assets/backgrounds/decorations/logo_leaf.png',
                  ),
                ),
              ],
            ),

            /// scroll-able content
            _introductionBody(size),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        nextPage: nextPage,
        prevPage: prevPage,
      ),
    );
  }

  _introductionBody(Size size) {
    //Creando el Scroll
    double spacedSize = size.height * 0.165;
    double fontSize = (size.height > 700) ? 1.2 : 1.1;
    if (size.height < 550) {
      spacedSize = size.height * 0.19;
    }
    if (size.height < 650) {
      spacedSize = size.height * 0.125;
    }
    return ListView(
      /// city logo
      children: [
        SizedBox(height: spacedSize),
        //Texto cambiar por funcionalidad de cuenta de días
        Text(this.chapterSettings.phaseName.toUpperCase(),
            textAlign: TextAlign.center,
            style: korolevFont.headline3
                ?.apply(fontSizeFactor: fontSize - 0.5, fontWeightDelta: -1)),
        SizedBox(height: 10),
        //Texto cambiar por funcionalidad de cuenta de días
        Text(this.chapterSettings.cityName.toUpperCase(),
            textAlign: TextAlign.center,
            style: korolevFont.headline1
                ?.apply(fontSizeFactor: fontSize - 0.5, fontWeightDelta: 5)),
        SizedBox(height: size.height * 0.05),
        _logoContainer(size),
        SizedBox(height: size.height * 0.07),
        Text(
          'Guiados por su dios tribal, Huitzilopochtli, los mexicas salieron de Aztlán en busca de "la señal" que indicaría el lugar para fundar México-Tenochtitlan.',
          style: korolevFont.bodyText1?.apply(fontSizeFactor: fontSize),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  _logoContainer(size) {
    return Container(
      //largo y ancho del logo dentro
      width: double.infinity,
      height: size.height * 0.35,
      child: Image(
        image: AssetImage(
          this.chapterSettings.chapterImageUrl,
        ),
        filterQuality: FilterQuality.high,
      ),
      padding: EdgeInsets.only(
        top: size.height * 0.04,
      ),
    );
  }
}
