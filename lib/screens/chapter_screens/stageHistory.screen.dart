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

  _historyBody1(Size size, String? texto) {
    
    double bodyMarginLeft = size.width * 0.05;
    return Container(
      //decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      margin: EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
      child: Text(
        texto!,
        style: korolevFont.headline6,
        textAlign: TextAlign.left,
      ),
    );
  }

  _historyBody2(Size size, String? texto) {
    
    double bodyMarginLeft = size.width * 0.05;
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      margin: EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
      child: Text(
        texto!,
        style: korolevFont.bodyText1,
        textAlign: TextAlign.left,
      ),
    );
  }

  

  _imageBody(Size size,String? url) {
    double marginRight = size.width * 0.05;
    double widthImagen = size.width * 0.20;
    double heightImagen = size.width * 0.20;
    if (size.width > 550) {
      widthImagen = size.width * 0.1;
      heightImagen = size.height * 0.2;
    } else {
      widthImagen = size.width * 0.17;
      heightImagen = size.height * 0.1;
    }
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: marginRight, left: marginRight),
      child:  Image(
        image: NetworkImage(
          url!,
        ),
        filterQuality: FilterQuality.high,
      ),
    );
  }

  

 Future<List<HistoryModel>> _readContents() async {
    List<dynamic> data = [];
    List<HistoryModel> contents = [];
    await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.widget.chapterSettings.id)
        .collection('pages')
        .doc('history')
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          data = documentSnapshot.get('content');
          // print('contents temp : $data'.toString());
          for (var i = 0; i < data.length; i++) {
            final contentTemp = new HistoryModel(
              height: data[i]?["height"],
              kind: data[i]["kind"],
              name: data[i]?["name"],
              path: data[i]?["path"],
              url: data[i]?["url"],
              width: data[i]?["width"],
              title: data[i]?["title"],              
              text: data[i]?["text"],            
            );

            contents.add(contentTemp);
          }
        }
      },
    );
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
            AsyncSnapshot<List<HistoryModel>> contents) {
          if (contents.hasError) {
            return Text(contents.error.toString());
          }

          if (contents.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
            );
          }
          List<Widget> contentsTemp = [];

          /// for that builds a specific widget depending on his kind
          for (HistoryModel content in contents.data!) {
            /// if kind == image then returns a image container
            if (content.kind.compareTo("HISTORY#IMAGE") == 0) {
              print("IMAGEN AÑADIDA: ");
              contentsTemp.add(SizedBox(height: 30));
              contentsTemp.add(_imageBody(size, content.url));
              contentsTemp.add(SizedBox(height: 30));
              

              
            } else if (content.kind.compareTo("HISTORY#TITLE") == 0) {
              print("TITULO AÑADIDO: ");
              contentsTemp.add(SizedBox(height: 30));
              contentsTemp.add(_historyBody1(size, content.title));
              contentsTemp.add(SizedBox(height: 30));
            }else if(content.kind.compareTo("HISTORY#TEXT")==0){
              print("TEXTO AÑADIDO: ");
              contentsTemp.add(SizedBox(height: 30));
              contentsTemp.add(_historyBody2(size, content.text));
              contentsTemp.add(SizedBox(height: 30));
            }
          }
          return Column(
            children: contentsTemp,
          );
        })
    );
  }
}
