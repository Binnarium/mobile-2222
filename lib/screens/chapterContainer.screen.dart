import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/stageIntroduction.screen.dart';
import 'package:lab_movil_2222/screens/stageTitle.screen.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';

class ChapterContainerScreen extends StatefulWidget {
  @override
  _ChapterContainerScreenState createState() => _ChapterContainerScreenState();
}

class _ChapterContainerScreenState extends State<ChapterContainerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PageView(
          children: [
            StageTitleScreen(),
            StageIntroductionScreen(),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
