import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageArgumentation.screen.dart';
import 'package:lab_movil_2222/shared/models/ChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class StageIntroductionScreen extends StatelessWidget {
  static const String route = '/introduction';
  final ChapterSettings chapterSettings;

  const StageIntroductionScreen({
    Key? key,
    required this.chapterSettings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return StageArgumentationScreen(
          chapterSettings: this.chapterSettings,
        );
      }));
    };

    final size = MediaQuery.of(context).size;
    print(size);
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          /// left
          if (details.delta.dx > 5) prevPage();

          /// right
          if (details.delta.dx < -5) nextPage();
        },
        child: Stack(
          children: [
            ChapterBackgroundWidget(
              backgroundColor: Color(int.parse(chapterSettings.primaryColor)),
              reliefPosition: 'bottom-right',
            ),
            _routeCurve(),
            _stageBody(size),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        nextPage: nextPage,
        prevPage: prevPage,
      ),
    );
  }

  _routeCurve() {
    return Container(
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage(
          'assets/backgrounds/decorations/white_route_curve_background.png',
        ),
        color: Color.fromRGBO(255, 255, 255, 100),
      ),
    );
  }

  ///scroll-able content
   _stageBody(Size size) {
    double bodyContainerHeight = size.height * 0.75;

    double spacedBodyContainers = bodyContainerHeight * 0.035;

    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      height: double.infinity,
      child: ListView(
        children: <Widget>[
          ChapterHeadWidget(
            phaseName: this.chapterSettings.phaseName,
            chapterName: this.chapterSettings.cityName,
            chapterImgURL: this.chapterSettings.chapterImageUrl,
          ),
          SizedBox(height: spacedBodyContainers),
          _imageOne(size),
          SizedBox(height: spacedBodyContainers),
          _objetBody1(size),
          SizedBox(height: spacedBodyContainers),
          _objetBody2(size),
          SizedBox(height: spacedBodyContainers),
          
          
          _imageTwo(size),
          SizedBox(height: spacedBodyContainers),
          _objetBody3(size),
          SizedBox(height: spacedBodyContainers),
          Container(
            width: double.infinity,
            height: bodyContainerHeight * 0.40,
            child: Image(
              image: AssetImage(
                'assets/backgrounds/decorations/white_idea_container.png',
              ),
            ),
          ),
          SizedBox(height: spacedBodyContainers + 20),
        ],
      ),
    );
  }

  _objetBody1(Size size) {
    String texto =
        'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium dolo remque laudantium, totam rem aperiam';
    double bodyMarginLeft = size.width * 0.05;
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      margin: EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
      child: Text(
        texto,
        style: korolevFont.bodyText1,
        textAlign: TextAlign.left,
      ),
    );
  }
  _objetBody(Size size) {
    String texto =
        'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium dolo remque laudantium, totam rem aperiam';
    double bodyMarginLeft = size.width * 0.05;
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      margin: EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
      child: Text(
        texto,
        style: korolevFont.bodyText1,
        textAlign: TextAlign.left,
      ),
    );
  }
  _objetBody2(Size size) {
    String texto =
        'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium dolo remque laudantium, totam rem aperiam';
    double bodyMarginLeft = size.width * 0.05;
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      margin: EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
      child: Text(
        texto,
        style: korolevFont.bodyText1,
        textAlign: TextAlign.left,
      ),
    );
  }
  _objetBody3(Size size) {
    String texto =
        'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium dolo remque laudantium, totam rem aperiam';
    double bodyMarginLeft = size.width * 0.05;
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      margin: EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
      child: Text(
        texto,
        style: korolevFont.bodyText1,
        textAlign: TextAlign.left,
      ),
    );
  }

  


  _imageOne(Size size) {
    double marginRight = size.width * 0.05;
    return Container(
      margin: EdgeInsets.only(right: marginRight,left: marginRight),
      
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.white)
      // ),
      child: Image(
        alignment: Alignment.centerLeft,
        width: size.width*0.19,
        height: size.height*0.16,
        image: AssetImage(
          'assets/backgrounds/decorations/logo_stage_prin.png',
        ),
      ),
    );
  }
  _imageTwo(Size size) {
    double marginRight = size.width * 0.05;
    double widthImagen = size.width*0.25;
    double heightImagen= size.width*0.20;
    if(size.width<390){
      widthImagen = size.width*0.26;
      heightImagen = size.height*0.26;
    }else{
      widthImagen = size.width*0.29;
      heightImagen = size.height*0.285;
    }
    return Container(
      margin: EdgeInsets.only(right: marginRight,left: marginRight),
      
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.white)
      // ),
      child: Image(
        alignment: Alignment.centerLeft,
        width: widthImagen,
        height: heightImagen,
        image: AssetImage(
          'assets/backgrounds/decorations/logo_stage_secun.png',
        ),
      ),
    );
  }

  
}
