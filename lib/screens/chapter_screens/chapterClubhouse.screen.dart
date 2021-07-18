import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageIntroduction.screen.dart';
import 'package:lab_movil_2222/shared/models/FirebaseChapterSettings.model.dart';

import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-subtitle-section.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/club-resources-grid-item_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ChapterClubhouseScreen extends StatefulWidget {
  static const String route = '/chapterClubhouse';
  final FirebaseChapterSettings chapterSettings;

  const ChapterClubhouseScreen({Key? key, required this.chapterSettings})
      : super(key: key);

  @override
  _ChapterClubhouseScreenState createState() => _ChapterClubhouseScreenState();
}

class _ChapterClubhouseScreenState extends State<ChapterClubhouseScreen> {
  late List<FirebaseChapterSettings> chapters;
  @override
  void initState() {
    super.initState();
    _asyncLecture();
  }

  void _asyncLecture() async {
    chapters = await _readChapterConfigurations();
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.pushNamed(
        context,
        StageIntroductionScreen.route,
        arguments: StageIntroductionScreen(
            chapterSettings: ((this.widget.chapterSettings.stage! + 1) > 12)
                ? chapters[0]
                : chapters[this.widget.chapterSettings.stage!]),
      );
    };
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: GestureDetector(
          ///To make the horizontal scroll to the next or previous page.
          onPanUpdate: (details) {
            /// left
            if (details.delta.dx > 5) prevPage();

            /// right
            if (details.delta.dx < -5) nextPage();
          },
          child: Stack(
            children: [
              ChapterBackgroundWidget(
                backgroundColor: Color(widget.chapterSettings.primaryColor),
                reliefPosition: 'bottom-right',
              ),

              ///body of the screen
              _resourcesContent(size),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        prevPage: prevPage,
      ),
    );
  }

  ///body of the screen
  _resourcesContent(Size size) {
    ///sizing the container to the mobile
    return Container(
      ///Listview of the whole screen
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          ChapterHeadWidget(
            phaseName: this.widget.chapterSettings.phaseName,
            chapterName: this.widget.chapterSettings.cityName,
            chapterImgURL: this.widget.chapterSettings.chapterImageUrl,
          ),
          SizedBox(
            height: 50,
          ),
          _titleClub(size),
          SizedBox(
            height: 10,
          ),
          _bodyClub(size),
          SizedBox(
            height: 20,
          ),
          ChapterSubtitleSection(
            title: 'PRÓXIMOS ENCUENTROS',
          ),
          SizedBox(
            height: 35,
          ),

          ///calling the body of online resources, expected a json
          _onlineResourcesBody(size, [
            2,
            3,
            2,
            1,
            2,
          ]),
        ],
      ),
    );
  }

  _titleClub(Size size) {
    String texto = 'CLUBHOUSE';

    return Container(
      child: Text(
        texto,
        style: korolevFont.headline2,
        textAlign: TextAlign.center,
      ),
    );
  }

  _bodyClub(Size size) {
    double bodyMarginWidth = size.width * 0.05;

    String texto =
        'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto.';

    return Container(
      margin: EdgeInsets.only(left: bodyMarginWidth, right: bodyMarginWidth),
      child: Text(
        texto,
        style: korolevFont.bodyText2,
        textAlign: TextAlign.center,
      ),
    );
  }

  ///Method of the online resources
  _onlineResourcesBody(Size size, List list) {
    ///main container
    return Container(
      ///To resize the parent container of the online resources grid

      margin: EdgeInsets.symmetric(horizontal: 5),

      ///Creates a grid with the necesary online resources
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15, mainAxisExtent: (size.height > 700) ? 200 : 180,
          // childAspectRatio: 1,
        ),
        itemCount: list.length,

        /// property that sizes the container automaticly according
        /// the items
        shrinkWrap: true,

        ///to avoid the scroll
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          ///calls the custom widget with the item parameters
          return ClubResourcesGridItem(
              theme: 'TEMA DEL ENCUENTRO',
              schedule: 'LUNES 12/06 // 13:30 HS.',
              agenda: 'AÑADIR A MI AGENDA');
        },
      ),
    );
  }

  Future<List<FirebaseChapterSettings>> _readChapterConfigurations() async {
    ///  reading chapter configurations
    List<FirebaseChapterSettings> settingsTemp = [];

    final snap = await FirebaseFirestore.instance
        .collection('cities')
        .orderBy("stage")
        .get();
    final settings = snap.docs
        .map((e) => FirebaseChapterSettings.fromJson(e.data()))
        .toList();
    settingsTemp = settings;
    return settingsTemp;
  }
}
