import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/services/load-arguments-screen-information.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/idea_container_widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

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
    Size size = MediaQuery.of(context).size;

    return Scaffold2222(
      city: this.widget.chapterSettings,
      backgrounds: [BackgroundDecorationStyle.topRight],
      route: StageArgumentationScreen.route,
      body: ListView(
        children: [
          LogosHeader(
            showStageLogoCity: this.widget.chapterSettings,
          ),
          if (this.questions != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              child: CustomBubbleList(
                ideas: this.questions!,
              ),
            )
          else
            AppLoading(),
        ],
      ),
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
                bubbleKind: BubbleKind.values[i % BubbleKind.values.length],
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
                    bubbleKind: BubbleKind.values[i % BubbleKind.values.length],
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
                  bubbleKind: BubbleKind.values[i % BubbleKind.values.length],
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
