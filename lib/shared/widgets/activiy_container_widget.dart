import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ActivityContainerWidget extends StatelessWidget {
  final double width;
  final double height;
  final String primaryColor;
  final Map<String, String> activities;

  const ActivityContainerWidget(
      {Key? key,
      required this.activities,
      required this.width,
      required this.height,
      required this.primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('grid width $width');
    print('grid height $height');
    SliverGridDelegate gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: width * 0.1,
        mainAxisSpacing: height * 0.25);

    ///for small height phones
    if (height < 400) {
      gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: width * 0.2,
          mainAxisSpacing: height * 0.3);
    }

    return Container(
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: gridDelegate,
          itemCount: activities.length,
          itemBuilder: (context, index) {
            ///to control the rotation of the widget
            Matrix4 rotation = Matrix4.rotationX(0);
            //rotación para poner el lado extenso en topRight
            Alignment iconAlignment = Alignment.topRight;
            String iconPath = '';
            String activityName = '';

            ///TODO: Await for a json sample to know how to handle every activity
            ///for now its hardcoded
            switch (index) {
              case 0:
                rotation = Matrix4.identity()
                  //matriz de perspectiva
                  ..setEntry(3, 2, 0.001)

                  ///rota manecilla de reloj en radianes
                  ..rotateZ(2.26893);
                iconAlignment = Alignment.topRight;
                iconPath = 'assets/icons/clubhouse_activity_icon.png';
                activityName = 'ClubHouse';
                break;

              case 1:
                rotation = Matrix4.identity()
                  //matriz de perspectiva
                  ..setEntry(3, 2, 0.001)

                  ///rota manecilla de reloj en radianes
                  ..rotateZ(3.31613);
                iconAlignment = Alignment.topLeft;
                iconPath = 'assets/icons/lectures_activity_icon.png';
                activityName = 'Círculo de Lectores';
                break;

              case 2:
                rotation = Matrix4.identity()
                  //matriz de perspectiva
                  ..setEntry(3, 2, 0.001)

                  ///rota manecilla de reloj en radianes
                  ..rotateZ(0);
                iconAlignment = Alignment.topLeft;

                iconPath = 'assets/icons/multiple_choice_activity_icon.png';
                activityName = 'Multiple Choice';
                break;

              case 3:
                rotation = Matrix4.identity()
                  //matriz de perspectiva
                  ..setEntry(3, 2, 0.001)

                  ///rota manecilla de reloj en radianes
                  ..rotateZ(4.71239);
                iconAlignment = Alignment.topRight;

                iconPath = 'assets/icons/project_activity_icon.png';
                activityName = 'Proyecto docente';
                break;
            }

            return _activity(width * 0.3, height * 0.3, rotation, iconAlignment,
                iconPath, activityName);
          }),
    );
  }

  Widget _activity(double width, double height, Matrix4 rotation,
      Alignment iconAlignment, String iconPath, String activityName) {
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.green)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform(
            transform: rotation,
            alignment: FractionalOffset.center,
            child: Image(
              image: AssetImage(
                  'assets/backgrounds/decorations/bubble_background_decoration_type2.png'),
              width: width * 1.2,
              height: height * 1.2,
            ),
          ),
          Image(
            alignment: iconAlignment,
            image: AssetImage(iconPath),
            width: width * 1.5,
            height: height * 1.5,
          ),
          _textContainer(width, height, activityName),
        ],
      ),
    );
  }

  _textContainer(double width, double height, String activityName) {
    print('width: $width');
    print('height: $height');

    return Container(
      margin: (height > 120)
          ? EdgeInsets.only(top: height * 0.17)
          : EdgeInsets.only(top: height * 0.25),
      alignment: Alignment.center,
      width: width,
      height: (height > 120) ? height * 0.7 : height * 0.7,
      padding: EdgeInsets.symmetric(horizontal: 15),
      // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            activityName.toUpperCase(),
            style: korolevFont.headline6?.apply(
              color: Color(int.parse(this.primaryColor)),
              fontSizeFactor: 0.7,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Tenim ipsam voluptatem  quia voluptas sit aspe natur aut odit aut fugit sed quia',
            style: korolevFont.bodyText2
                ?.apply(color: Colors.black, fontSizeFactor: 0.7),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: (height > 120) ? 5 : 3,
          ),
        ],
      ),
    );
  }
}
