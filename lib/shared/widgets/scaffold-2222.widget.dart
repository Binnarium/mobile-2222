import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageHistory.screen.dart';

import 'custom_navigation_bar.dart';

enum BackgroundDecoration {
  topRight,
  topLeft,
  bottomRight,
  bottomLeft,
  path,
}

const Map<BackgroundDecoration, ImageProvider> BackgroundsDecorations = {
  BackgroundDecoration.topLeft:
      AssetImage('assets/backgrounds/background-decorations/top-left.png'),
  BackgroundDecoration.topRight:
      AssetImage('assets/backgrounds/background-decorations/top-right.png'),
  BackgroundDecoration.bottomLeft:
      AssetImage('assets/backgrounds/background-decorations/bottom-left.png'),
  BackgroundDecoration.bottomRight:
      AssetImage('assets/backgrounds/background-decorations/bottom-right.png'),
  BackgroundDecoration.path:
      AssetImage('assets/backgrounds/background-decorations/path.png'),
};

class Scaffold2222 extends StatelessWidget {
  const Scaffold2222({
    Key? key,
    required this.body,
    required this.city,
    this.backgroundPosition,
  }) : super(key: key);

  final Widget body;
  final BackgroundDecoration? backgroundPosition;
  final CityDto city;

  @override
  Widget build(BuildContext context) {
    /// back button
    VoidCallback prevPage = () => Navigator.pop(context);

    /// next page button
    VoidCallback nextPage = () => Navigator.pushNamed(
          context,
          StageHistoryScreen.route,
          arguments: StageHistoryScreen(
            city: this.city,
          ),
        );

    /// page layout
    return Scaffold(
      backgroundColor: this.city.color,

      /// add bottom navigation
      bottomNavigationBar: CustomNavigationBar(
        nextPage: nextPage,
        prevPage: prevPage,
      ),

      /// wrap everything in a gesture detector to move across cities
      body: GestureDetector(
        onPanUpdate: (details) {
          /// left
          if (details.delta.dx > 5) prevPage();

          /// right
          if (details.delta.dx < -5) nextPage();
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              /// background image align to top
              if (this.backgroundPosition == BackgroundDecoration.topRight ||
                  this.backgroundPosition == BackgroundDecoration.topLeft)
                Positioned.fill(
                  child: Image(
                    image: BackgroundsDecorations[this.backgroundPosition]!,
                    width: double.infinity,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fitWidth,
                  ),
                ),

              /// background image align to bottom
              if (this.backgroundPosition == BackgroundDecoration.bottomLeft ||
                  this.backgroundPosition == BackgroundDecoration.bottomRight)
                Positioned.fill(
                  child: Image(
                    alignment: Alignment.bottomCenter,
                    image: BackgroundsDecorations[this.backgroundPosition]!,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ),

              /// background path decoration
              if (this.backgroundPosition == BackgroundDecoration.path)
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Image(
                    image: BackgroundsDecorations[this.backgroundPosition]!,
                    width: double.infinity,
                  ),
                ),

              /// main content
              Positioned.fill(child: this.body),
            ],
          ),
        ),
      ),
    );
  }
}
