import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageobjectives.screen.dart';
import 'package:lab_movil_2222/services/load-arguments-screen-information.service.dart';
import 'package:lab_movil_2222/shared/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/idea_container_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class StageArgumentationScreen extends StatefulWidget {
  static const String route = '/argumentation';

  final CityDto chapterSettings;

  const StageArgumentationScreen({
    Key? key,
    required this.chapterSettings,
  }) : super(key: key);

  @override
  _StageArgumentationScreenState createState() =>
      _StageArgumentationScreenState();
}

class _StageArgumentationScreenState extends State<StageArgumentationScreen> {
  List<String>? questions;

  @override
  void initState() {
    super.initState();
    ILoadInformationWithOptions<List<String>, CityDto> loader =
        LoadArgumentScreenInformationService(
      chapterSettings: this.widget.chapterSettings,
    );
    loader.load().then((value) => this.setState(() => questions = value));
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.pushNamed(
        context,
        StageObjetivesScreen.route,
        arguments: StageObjetivesScreen(
          chapterSettings: this.widget.chapterSettings,
        ),
      );
    };

    Size size = MediaQuery.of(context).size;

    print(size);
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (panning) {
          /// left
          if (panning.delta.dx > 5) prevPage();

          /// right
          if (panning.delta.dx < -5) nextPage();
        },
        child: Stack(
          children: [
            //widget custom que crea el background con el logo de la izq
            ChapterBackgroundWidget(
              backgroundColor: widget.chapterSettings.color,
              reliefPosition: 'top-right',
            ),
            //decoración adicional del background
            _backgroundDecoration(size),
            // _ideas(size),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        nextPage: nextPage,
        prevPage: prevPage,
      ),
    );
  }

  _backgroundDecoration(Size size) {
    return ListView(
      children: [
        SizedBox(
          height: 10,
        ),
        ChapterHeadWidget(
          showStageLogo: true,
          city: this.widget.chapterSettings,
        ),
        if (this.questions != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: CustomBubbleList(
              ideas: this.questions!,
            ),
          )
        else
          Center(
            child: CircularProgressIndicator(
              color: ColorsApp.white,
            ),
          ),
      ],
    );
  }
}

class CustomBubbleList extends StatelessWidget {
  CustomBubbleList({
    Key? key,
    required this.ideas,
  })  : this.seed = Random(DateTime.now().hour),
        super(key: key) {
    this.ideas.shuffle(this.seed);
  }

  final Random seed;
  final List<String> ideas;

  @override
  Widget build(BuildContext context) {
    final List<Widget> colItems = [];

    /// List created
    ///
    ///   0           one item row
    /// 1,  ,         two items row
    ///  , 2,         one item row
    /// 3,            and so on...
    for (int i = 0; i < this.ideas.length; i++) {
      // single item row
      if (i == 0) {
        String current = this.ideas[i];
        colItems.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Container(
              constraints: BoxConstraints(maxWidth: 360),
              child: IdeaContainerWidget(
                text: current,
                orientation: i,
                bigStyle: true,
              ),
            ),
          ),
        );
        continue;
      }
      if (i % 2 == 1) {
        String current = this.ideas[i];
        colItems.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: IdeaContainerWidget(
                    text: current,
                    orientation: i,
                  ),
                ),
                Flexible(child: Container())
              ],
            ),
          ),
        );
        continue;
      }
      String current = this.ideas[i];
      colItems.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Flexible(child: Container()),
              Flexible(
                flex: 2,
                child: IdeaContainerWidget(
                  text: current,
                  orientation: i,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: colItems..shuffle(this.seed),
    );
  }
}
