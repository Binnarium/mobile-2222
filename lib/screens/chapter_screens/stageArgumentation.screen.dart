import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/services/load-arguments-screen-information.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/idea_container_widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class StageArgumentationScreen extends StatefulWidget {
  static const String route = '/argumentation';

  final CityModel city;

  const StageArgumentationScreen({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  _StageArgumentationScreenState createState() =>
      _StageArgumentationScreenState();
}

class _StageArgumentationScreenState extends State<StageArgumentationScreen> {
  List<String>? questions;

  StreamSubscription? _loadQuestionsSub;

  @override
  void initState() {
    super.initState();

    LoadArgumentScreenInformationService loadQuestionsService =
        Provider.of<LoadArgumentScreenInformationService>(context,
            listen: false);

    // loadContentsService.load$(widget.city);
    _loadQuestionsSub = loadQuestionsService.load$(widget.city).listen(
      (cityQuestions) {
        if (mounted) {
          setState(() {
            questions = cityQuestions;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _loadQuestionsSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold2222.city(
      city: widget.city,
      backgrounds: [BackgroundDecorationStyle.topRight],
      route: StageArgumentationScreen.route,
      body: ListView(
        children: [
          LogosHeader(
            showStageLogoCity: widget.city,
          ),
          if (questions != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              child: CustomBubbleList(
                ideas: questions!,
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
  })  : seed = Random(DateTime.now().hour),
        super(key: key) {
    ideas.shuffle(seed);
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
    for (int i = 0; i < ideas.length; i++) {
      // single item row
      if (i == 0) {
        String current = ideas[i];
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
        String current = ideas[i];
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
      String current = ideas[i];
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
      children: colItems..shuffle(seed),
    );
  }
}
