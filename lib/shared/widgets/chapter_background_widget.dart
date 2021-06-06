import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/background_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ChapterBackgroundWidget extends StatelessWidget {
  final Color backgroundColor;

  const ChapterBackgroundWidget({required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          BackgroundWidget(backgroundColor: ColorsApp.backgroundOrange),
          _logoLeaf(),
        ],
      ),
    );
  }

  _logoLeaf() {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage(
          'assets/backgrounds/decorations/logo_leaf.png',
        ),
      ),
    );
  }
}
