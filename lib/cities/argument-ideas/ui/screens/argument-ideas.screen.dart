import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/argument-ideas/services/arguments-ideas.service.dart';
import 'package:lab_movil_2222/cities/argument-ideas/ui/widget/idea-bubble.widget.dart';
import 'package:lab_movil_2222/home-map/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class ArgumentIdeasScreen extends StatefulWidget {
  const ArgumentIdeasScreen({
    Key? key,
    required this.city,
  }) : super(key: key);

  static const String route = '/argumentation';

  final CityModel city;

  @override
  _ArgumentIdeasScreenState createState() => _ArgumentIdeasScreenState();
}

class _ArgumentIdeasScreenState extends State<ArgumentIdeasScreen> {
  StreamSubscription? _loadSub;

  List<String>? ideas;

  ArgumentIdeasService get _argumentIdeasService =>
      Provider.of<ArgumentIdeasService>(context, listen: false);

  @override
  void initState() {
    super.initState();

    _loadSub = _argumentIdeasService.load$(widget.city).listen(
      (cityQuestions) {
        if (mounted) {
          setState(() => ideas = cityQuestions);
        }
      },
    );
  }

  @override
  void dispose() {
    _loadSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2222.city(
      city: widget.city,
      backgrounds: const [BackgroundDecorationStyle.topRight],
      route: ArgumentIdeasScreen.route,
      body: ListView(
        children: [
          /// header
          LogosHeader(showStageLogoCity: widget.city),

          /// loading and bubbles container
          if (ideas == null)
            const AppLoading()
          else
            CustomBubbleList(ideas: ideas!),
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
    final Size size = MediaQuery.of(context).size;
    final List<Widget> colItems = [];

    for (int i = 0; i < ideas.length; i++) {
      colItems.add(
        Row(
          mainAxisAlignment:
              i.isEven ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: 16,
                left: size.width * 0.08,
                right: size.width * 0.08,
              ),
              child: IdeaBubbleWidget(
                text: ideas[i],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: colItems,
    );
  }
}
