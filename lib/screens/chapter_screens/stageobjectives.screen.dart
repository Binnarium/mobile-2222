import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/home-map/models/city.dto.dart';
import 'package:lab_movil_2222/models/Competence.model.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-title-section.dart';
import 'package:lab_movil_2222/shared/widgets/compe-resources-list-item_widget.dart';
import 'package:lab_movil_2222/shared/widgets/idea-resources-list-item_widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';

class StageObjetivesScreen extends StatefulWidget {
  const StageObjetivesScreen({Key? key, required this.city}) : super(key: key);

  static const String route = '/objectives';
  final CityModel city;

  @override
  _StageObjectivesScreenState createState() => _StageObjectivesScreenState();
}

class _StageObjectivesScreenState extends State<StageObjetivesScreen> {
  @override
  void initState() {
    _asyncLecture();
    super.initState();
  }

  Future<void> _asyncLecture() async {
    await _readCompetences();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold2222.city(
      city: widget.city,
      backgrounds: const [BackgroundDecorationStyle.topRight],
      route: StageObjetivesScreen.route,
      body: _stageBody(size),
    );
  }

  Container _stageBody(Size size) {
    final double bodyContainerHeight = size.height * 0.75;

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
          LogosHeader(
            showStageLogoCity: widget.city,
          ),
          SizedBox(height: spacedBodyContainers),
          ChapterTitleSection(
            title: 'OBJETIVO',
          ),
          SizedBox(height: spacedBodyContainers + 15),
          _objetBody(size),
          SizedBox(height: spacedBodyContainers + 15),
          ChapterTitleSection(
            title: 'IDEAS PARA DESAPRENDER',
          ),
          SizedBox(height: spacedBodyContainers),
          _ideasBody(size),
          SizedBox(height: spacedBodyContainers),
          ChapterTitleSection(
            title: 'COMPETENCIAS',
          ),
          SizedBox(height: spacedBodyContainers + 10),
          _compeBody(size),
        ],
      ),
    );
  }

  Container _objetBody(Size size) {
    return Container(
        // decoration: BoxDecoration(border: Border.all(color: Colors.white)),

        padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
        child: FutureBuilder(
          future: _readObjective(),
          builder: (BuildContext context, AsyncSnapshot<String> objective) {
            if (objective.hasError) {
              return Text(objective.error.toString());
            }

            if (objective.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    widget.city.color,
                  ),
                ),
              );
            }
            return Markdown2222(
              data: objective.data.toString(),
            );
          },
        ));
  }

  Container _ideasBody(Size size) {
    ///main container
    return Container(
      ///general left padding 25
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),

      ///To resize the parent container of the list of books
      //height: (list.length) * bodyContainerHeight * 0.0825,
      child: FutureBuilder(
          future: _readIdea(),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> contents) {
            if (contents.hasError) {
              return Text(contents.error.toString());
            }

            if (contents.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    widget.city.color,
                  ),
                ),
              );
            }

            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: contents.data?.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final String texto =
                      contents.data!.elementAt(index) as String;
                  return IdeaResourcesListItem(description: texto);
                });
          }),
    );
  }

  Container _compeBody(Size size) {
    ///main container
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),

      ///To resize the parent container of the online resources grid
      ///Creates a grid with the necesary online resources
      child: FutureBuilder(
        future: _readCompetences(),
        builder:
            (BuildContext context, AsyncSnapshot<List<CompetenceModel>> compe) {
          if (compe.hasError) {
            return Text(compe.error.toString());
          }

          if (compe.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.city.color,
                ),
              ),
            );
          }
          final List<CompetenceModel>? compeTemp = compe.data;

          return Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0, top: 10),
              child: Wrap(
                spacing: size.width * 0.08,
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  for (var item in compeTemp!)
                    CompeResourcesListItem(
                      name: item.name,
                      image: item.image,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<String> _readObjective() async {
    String contentsTemp = '';
    await FirebaseFirestore.instance
        .collection('cities')
        .doc(widget.city.id)
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
    final DocumentSnapshot objectiveSnapshot = await FirebaseFirestore.instance
        .collection('cities')
        .doc(widget.city.id)
        .collection('pages')
        .doc('objective')
        .get();

    if (objectiveSnapshot.exists) {
      final dynamic data = objectiveSnapshot.data()!;
      //to access to firebase reference
      final List<Future<CompetenceModel>> ideasRef =
          (data['competences'] as List<dynamic>)
              .map((dynamic e) => e as DocumentReference)
              .map((e) async {
        final payload = await e.get();

        return CompetenceModel(
            name: payload['name'] as String,
            image: payload['image'] as Map<String, dynamic>);
      }).toList();

      return Future.wait(ideasRef);
    }

    return [];
  }

  Future<List<dynamic>> _readIdea() async {
    List<dynamic> ideaTemp = <dynamic>[];
    await FirebaseFirestore.instance
        .collection('cities')
        .doc(widget.city.id)
        .collection('pages')
        .doc('objective')
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          ideaTemp = documentSnapshot.get('ideas') as List<dynamic>;
        }
      },
    );
    return ideaTemp;
  }
}
