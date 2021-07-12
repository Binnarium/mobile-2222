import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageArgumentation.screen.dart';
import 'package:lab_movil_2222/shared/models/FirebaseChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/models/History.model.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class StageHistoryScreen extends StatefulWidget {
  static const String route = '/history';
  final FirebaseChapterSettings chapterSettings;

  const StageHistoryScreen({
    Key? key,
    required this.chapterSettings,
  }) : super(key: key);
  @override
  _StageHistoryScreenState createState() => _StageHistoryScreenState();
}

class _StageHistoryScreenState extends State<StageHistoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.pushNamed(
        context,
        StageArgumentationScreen.route,
        arguments: StageArgumentationScreen(
          chapterSettings: this.widget.chapterSettings,
        ),
      );
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
              backgroundColor: Color(this.widget.chapterSettings.primaryColor),
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

    double spacedBodyContainers = bodyContainerHeight * 0.04;

    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      height: double.infinity,
      child: ListView(
        children: <Widget>[
          ChapterHeadWidget(
            phaseName: this.widget.chapterSettings.phaseName,
            chapterName: this.widget.chapterSettings.cityName,
            chapterImgURL: this.widget.chapterSettings.chapterImageUrl,
          ),
          SizedBox(height: spacedBodyContainers),
          // _imageOne(size),
          _contentsBody(size),
        ],
      ),
    );
  }

  Widget _titleHistory(Size size, TitleHistoryDto history) {
    double bodyMarginLeft = size.width * 0.05;
    return Container(
      //decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft,bottom: bodyMarginLeft),
      
      child: history.title == null
          ? Text(
              'No se ha cargado texto',
              style: korolevFont.headline6,
              textAlign: TextAlign.left,
            )
          : Text(
              history.title as String,
              style: korolevFont.headline6,
              textAlign: TextAlign.left,
            ),
    );
  }

  Widget _textHistory(Size size, TextHistoryDto history) {
    double bodyMarginLeft = size.width * 0.05;
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft,bottom: bodyMarginLeft),
      child: history.text == null
          ? Text('No se ha cargado texto')
          : Text(
              history.text as String,
              style: korolevFont.bodyText1,
              textAlign: TextAlign.left,
            ),
    );
  }

  Widget _buildHistoryImage(Size size, ImageHistoryDto history) {
    double marginRight = size.width * 0.05;
    // double widthImagen = size.width * 0.20;
    // double heightImagen = size.width * 0.20;

    // if (size.width > 550) {
    //   widthImagen = size.width * 0.1;
    //   heightImagen = size.height * 0.2;
    // } else {
    //   widthImagen = size.width * 0.17;
    //   heightImagen = size.height * 0.1;
    // }
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: marginRight, left: marginRight,bottom: marginRight),
      child: history.url == null
          ? Container(
            alignment: Alignment.center,
            height: 150,
            width: 150,
            color: Colors.black,
            child: Text('No ha imagen subida',textAlign: TextAlign.center,),
          )
          : Image(
              image: NetworkImage(
                history.url as String,
              ),
              filterQuality: FilterQuality.high,
            ),
    );
  }

  Future<List<HistoryDto>> _readContents() async {
    final snap = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.widget.chapterSettings.id)
        .collection('pages')
        .doc('history')
        .get();

    /// validate the documents has data
    if (!snap.exists) new ErrorDescription('Document history does not exists');

    /// get content of document for later iterations
    final Map<String, dynamic> payload = snap.data() as Map<String, dynamic>;
    final List<dynamic> data = payload['content'];

    /// turn the list into list of history dot's
    final contents = data.map((e) => HistoryDto.fromJson(e)).toList();

    return contents;
  }

  _contentsBody(Size size) {
    double bodyMarginLeft = size.width * 0.05;

    ///main container
    return Container(

        ///general left padding 25
        width: double.infinity,
        margin: EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
        alignment: Alignment.centerLeft,

        ///To resize the parent container of the list of books
        //height: (list.length) * bodyContainerHeight * 0.125,
        child: FutureBuilder(
            future: _readContents(),
            builder: (BuildContext context,
                AsyncSnapshot<List<HistoryDto>> contents) {
              if (contents.hasError) return Text(contents.error.toString());

              if (contents.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                );

              final List<HistoryDto> historyContent =
                  contents.data as List<HistoryDto>;

              final List<Widget> contentWidgets = historyContent.map((history) {
                if (history is TitleHistoryDto)
                  return _titleHistory(size, history);
                if (history is ImageHistoryDto)
                  return _buildHistoryImage(size, history);
                if (history is TextHistoryDto)
                  return _textHistory(size, history);
                throw ErrorDescription('Kind of history content not found');
              }).toList();

              return Column(
                children: contentWidgets,
              );
            }));
  }
}
