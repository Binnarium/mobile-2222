import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/content.screen.dart';
import 'package:lab_movil_2222/shared/models/Competence.model.dart';
import 'package:lab_movil_2222/shared/models/FirebaseChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-title-section.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/compe-resources-list-item_widget.dart';
import 'package:lab_movil_2222/shared/widgets/conten-resources-list-item_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/idea_unlearn_container_widget.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class StageObjetivesScreen extends StatefulWidget {
  static const String route = '/objectives';
  final FirebaseChapterSettings chapterSettings;

  const StageObjetivesScreen({Key? key, required this.chapterSettings})
      : super(key: key);

  @override
  _StageObjectivesScreenState createState() => _StageObjectivesScreenState();
}

class _StageObjectivesScreenState extends State<StageObjetivesScreen> {
  @override
  void initState() {
    _asyncLecture();
    super.initState();
  }

  void _asyncLecture() async {
    await _readContents();
    await _readCompetences();
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.pushNamed(
        context,
        ContentScreen.route,
        arguments: ContentScreen(
          chapterSettings: this.widget.chapterSettings,
        ),
      );
    };

    final size = MediaQuery.of(context).size;
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
              reliefPosition: 'top-left',
            ),
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

  _stageBody(Size size) {
    double bodyContainerHeight = size.height * 0.75;

    double spacedBodyContainers = bodyContainerHeight * 0.035;
    if (size.width > 550) {
      spacedBodyContainers = bodyContainerHeight * 0.065;
    }

    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      height: double.infinity,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          ChapterHeadWidget(
            phaseName: this.widget.chapterSettings.phaseName,
            chapterName: this.widget.chapterSettings.cityName,
            chapterImgURL: this.widget.chapterSettings.chapterImageUrl,
          ),
          SizedBox(height: spacedBodyContainers),
          ChapterTitleSection(
            title: 'OBJETIVO',
          ),
          SizedBox(height: spacedBodyContainers + 15),
          _objetBody(size),
          SizedBox(height: spacedBodyContainers + 15),
          ChapterTitleSection(
            title: 'CONTENIDOS',
          ),
          SizedBox(height: spacedBodyContainers),
          _contentsBody(size),
          SizedBox(height: spacedBodyContainers),
          ChapterTitleSection(
            title: 'COMPETENCIAS',
          ),
          SizedBox(height: spacedBodyContainers + 10),
          _compeBody(size),
          SizedBox(height: spacedBodyContainers + 20),
          _decorationWhite(size),
          SizedBox(height: spacedBodyContainers + 20),
        ],
      ),
    );
  }

  _objetBody(Size size) {
    double bodyMarginLeft = size.width * 0.05;
    return Container(
        // decoration: BoxDecoration(border: Border.all(color: Colors.white)),

        margin: EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
        child: FutureBuilder(
          future: _readObjective(),
          builder: (BuildContext context, AsyncSnapshot<String> objective) {
            if (objective.hasError) {
              return Text(objective.error.toString());
            }

            if (objective.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color(this.widget.chapterSettings.primaryColor),
                  ),
                ),
              );
            }
            return Text(
              objective.data.toString(),
              style: korolevFont.bodyText1,
              textAlign: TextAlign.left,
            );
          },
        ));
  }

  _contentsBody(Size size) {
    double bodyMarginLeft = size.width * 0.05;

    ///main container
    return Container(
      ///general left padding 25
      width: double.infinity,
      margin: EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),

      ///To resize the parent container of the list of books
      //height: (list.length) * bodyContainerHeight * 0.125,
      child: FutureBuilder(
          future: _readContents(),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> contents) {
            if (contents.hasError) {
              return Text(contents.error.toString());
            }

            if (contents.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color(this.widget.chapterSettings.primaryColor),
                  ),
                ),
              );
            }

            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: contents.data?.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  String texto = contents.data!.elementAt(index);
                  return ContenResourcesListItem(
                      index: '${index + 1}', description: texto);
                });
          }),
    );
  }

  _compeBody(Size size) {
    double bodyMarginWidth = size.width * 0.05;

    ///main container
    return Container(
      margin: EdgeInsets.only(left: 25, right: bodyMarginWidth),

      ///To resize the parent container of the online resources grid

      ///Creates a grid with the necesary online resources
      child: FutureBuilder(
          future: _readCompetences(),
          builder: (BuildContext context,
              AsyncSnapshot<List<CompetenceModel>> compe) {
            if (compe.hasError) {
              return Text(compe.error.toString());
            }

            if (compe.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color(this.widget.chapterSettings.primaryColor),
                  ),
                ),
              );
            }
            final List<CompetenceModel> compeTemp =
                compe.data as List<CompetenceModel>;
            return GridView.builder(
              ///general spacing per resource
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                mainAxisExtent: (size.height > 700) ? 200 : 180,
                // childAspectRatio: 1,
              ),
              itemCount: compeTemp.length,

              /// property that sizes the container automaticly according
              /// the items
              shrinkWrap: true,

              ///to avoid the scroll
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                ///calls the custom widget with the item parameters
                final item = compeTemp.elementAt(index);
                if (item is CompetenceModel) {
                  return CompeResourcesListItem(
                    name: item.name,
                    image: item.image,
                  );
                }
                return Text('Kind of content not found');
              },
            );
          }),
    );
  }

  _decorationWhite(Size size) {
    double bodyContainerHeight = size.height * 0.35;
    double bodyContainerWidth = size.width * 0.95;
    if (size.width > 500) {
      bodyContainerHeight = size.height * 0.80;
    }

    return Container(
        child: FutureBuilder(
            future: _readIdea(),
            builder: (BuildContext context, AsyncSnapshot<List<dynamic>> idea) {
              if (idea.hasError) {
                return Text(idea.error.toString());
              }

              if (idea.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                      Color(this.widget.chapterSettings.primaryColor),
                    ),
                  ),
                );
              }
              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String texto = idea.data!.elementAt(0);
                    return IdeaUnlearnContainerWidget(
                      text: texto,
                      color: Color(this.widget.chapterSettings.primaryColor),
                      width: bodyContainerWidth,
                      height: bodyContainerHeight,
                    );
                  });
            }));
  }

  Future<List<dynamic>> _readContents() async {
    List contentsTemp = [];
    await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.widget.chapterSettings.id)
        .collection('pages')
        .doc('objective')
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          contentsTemp = documentSnapshot.get('content');
        }
      },
    );
    return contentsTemp;
  }

  Future<String> _readObjective() async {
    String contentsTemp = "";
    await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.widget.chapterSettings.id)
        .collection('pages')
        .doc('objective')
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          contentsTemp = documentSnapshot.get('mainObjective').toString();

          // print('ideas temp : $contentsTemp');
        }
      },
    );
    return contentsTemp;
  }

  Future<List<CompetenceModel>> _readCompetences() async {
    DocumentSnapshot objectiveSnapshot = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.widget.chapterSettings.id)
        .collection('pages')
        .doc('objective')
        .get();

    if (objectiveSnapshot.exists) {
      dynamic data = objectiveSnapshot.data()!;
      //to access to firebase reference
      List<Future<CompetenceModel>> ideasRef =
          (data['competences'] as List<dynamic>)
              .map((e) => e as DocumentReference)
              .map((e) async {
        final payload = await e.get();

        return CompetenceModel(name: payload['name'], image: payload['image']);
      }).toList();

      return await Future.wait(ideasRef);
    }

    return [];
  }

  Future<List<dynamic>> _readIdea() async {
    List<dynamic> ideaTemp = [];
    await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.widget.chapterSettings.id)
        .collection('pages')
        .doc('objective')
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          ideaTemp = documentSnapshot.get('ideas');
        }
      },
    );
    return ideaTemp;
  }
}
