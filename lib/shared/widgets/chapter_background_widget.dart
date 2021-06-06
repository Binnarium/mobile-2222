import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/background_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ChapterBackgroundWidget extends StatelessWidget {
  final Color backgroundColor;
  final Container? relieve;

  ChapterBackgroundWidget({required this.backgroundColor, this.relieve});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          BackgroundWidget(backgroundColor: ColorsApp.backgroundOrange),
          _relieve(),
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

  _relieve() {
    if (relieve == null) {
      return Container();
    } else {
      return relieve;
    }
  }
}
