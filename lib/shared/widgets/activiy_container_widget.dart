import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ActivityContainerWidget extends StatelessWidget {
  final double width;
  final double height;
  final String primaryColor;
  final Map<String, dynamic> enabledActivities;

  const ActivityContainerWidget(
      {Key? key,
      required this.enabledActivities,
      required this.width,
      required this.height,
      required this.primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('grid width $width');
    // print('grid height $height');
    SliverGridDelegate gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: width * 0.2,
        mainAxisSpacing: height * 0.3);

    ///for small height phones
    if (height < 700) {
      gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: width * 0.2,
          mainAxisSpacing: height * 0.3);
    }

    List<_ActivityItem> showActivities = _showActivities(enabledActivities);

    return Container(
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: gridDelegate,
          itemCount: 4,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            /// to avoid the null in the grid view
            if (showActivities.length < 4) {
              if (index >= showActivities.length) {
                return Container();
              }
            }
            Matrix4 rotation = showActivities.elementAt(index).rotation;
            //rotación para poner el lado extenso en topRight
            Alignment iconAlignment = showActivities.elementAt(index).alignment;
            String iconPath = showActivities.elementAt(index).iconPath;
            String activityName = showActivities.elementAt(index).name;
            return _activity(width * 0.4, height * 0.4, rotation, iconAlignment,
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
        // fit: StackFit.expand,
        children: [
          Transform(
            transform: rotation,
            alignment: FractionalOffset.center,
            child: Image(
              image: AssetImage(
                  'assets/backgrounds/decorations/bubble_background_decoration_type2.png'),
              // width: width,
              // height: height,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            alignment: iconAlignment,
            child: Image(
              image: AssetImage(iconPath),
              width: (height > 155) ? width * 0.25 : width * 0.25,
              height: (height > 155) ? height * 0.25 : height * 0.25,
            ),
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
      // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      margin: (height > 120)
          ? (height > 175)
              ? EdgeInsets.only(top: 0)
              : EdgeInsets.only(top: height * 0.1, bottom: height * 0.05)
          : EdgeInsets.only(top: height * 0.25),
      alignment: Alignment.center,
      width: width * 1.3,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            activityName.toUpperCase(),
            style: korolevFont.headline6?.apply(
              color: Color(int.parse(this.primaryColor)),
              fontSizeFactor: 0.8,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: (height > 155) ? 10 : 5,
          ),
          Text(
            'Tenim ipsam voluptatem  quia voluptas sit aspe natur aut odit aut fugit sed quia',
            style: korolevFont.bodyText1
                ?.apply(color: Colors.black, fontSizeFactor: 0.7),
            // overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            // maxLines: (height > 120) ? 5 : 3,
          ),
        ],
      ),
    );
  }
}

class _ActivityItem {
  final String name;
  final Matrix4 rotation;
  final Alignment alignment;
  final String iconPath;

  _ActivityItem(
      {required this.name,
      required this.rotation,
      required this.alignment,
      required this.iconPath});
}

List<_ActivityItem> _showActivities(Map<String, dynamic> activitiesToPaint) {
  Map<int, Map<String, dynamic>> activitiesSettings = {
    0: {
      "rotation": Matrix4.identity()
        //matriz de perspectiva
        ..setEntry(3, 2, 0.001)

        ///rota manecilla de reloj en radianes
        ..rotateZ(2.26893),
      "iconAlignment": Alignment.topRight,
    },
    1: {
      "rotation": Matrix4.identity()
        //matriz de perspectiva
        ..setEntry(3, 2, 0.001)

        ///rota manecilla de reloj en radianes
        ..rotateZ(3.31613),
      "iconAlignment": Alignment.topLeft,
    },
    2: {
      "rotation": Matrix4.identity()
        //matriz de perspectiva
        ..setEntry(3, 2, 0.001)

        ///rota manecilla de reloj en radianes
        ..rotateZ(0),
      "iconAlignment": Alignment.topLeft,
    },
    3: {
      "rotation": Matrix4.identity()
        //matriz de perspectiva
        ..setEntry(3, 2, 0.001)

        ///rota manecilla de reloj en radianes
        ..rotateZ(4.71239),
      "iconAlignment": Alignment.topRight,
    },
    4: {}
  };

  List<_ActivityItem> activities = [];
  Map<String, dynamic> enabledActivitiesTemp = new Map();
  enabledActivitiesTemp = activitiesToPaint;
  int index = 0;
  for (var item in enabledActivitiesTemp.entries) {
    if (item.key == "clubhouse" && item.value == true) {
      activities.add(new _ActivityItem(
        name: 'Eventos ClubHouse',
        rotation: activitiesSettings[index]!["rotation"],
        alignment: activitiesSettings[index]!["iconAlignment"],
        iconPath: 'assets/icons/clubhouse_activity_icon.png',
      ));
      index++;
    } else if (item.key == "readings" && item.value == true) {
      activities.add(new _ActivityItem(
        name: 'Círculo de Lectores',
        rotation: activitiesSettings[index]?["rotation"],
        alignment: activitiesSettings[index]?["iconAlignment"],
        iconPath: 'assets/icons/lectures_activity_icon.png',
      ));
      index++;
    } else if (item.key == "questionary" && item.value == true) {
      activities.add(new _ActivityItem(
        name: 'Cuestionario',
        rotation: activitiesSettings[index]!["rotation"],
        alignment: activitiesSettings[index]!["iconAlignment"],
        iconPath: 'assets/icons/multiple_choice_activity_icon.png',
      ));
      index++;
    } else if (item.key == "project" && item.value == true) {
      activities.add(new _ActivityItem(
        name: 'Proyecto docente',
        rotation: activitiesSettings[index]!["rotation"],
        alignment: activitiesSettings[index]!["iconAlignment"],
        iconPath: 'assets/icons/project_activity_icon.png',
      ));
      index++;
    }
  }
  return activities;
}
