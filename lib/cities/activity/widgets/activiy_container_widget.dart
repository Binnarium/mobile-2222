import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/activity/model/city-activity.model.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ActivitiesWidget extends StatelessWidget {
  final CityDto city;
  final CityActivityModel activity;

  const ActivitiesWidget({
    Key? key,
    required this.city,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> activities = [];
    if (this.city.enabledPages.contribution) {
      activities.add(_activity(
          context,
          size,
          "Tu Contribución",
          "assets/icons/multiple_choice_activity_icon.png",
          activity.contribution));
      activities.add(SizedBox(
        height: 20,
      ));
    }
    if (this.city.enabledPages.clubhouse) {
      activities.add(_activity(context, size, "Eventos Clubhouse",
          "assets/icons/clubhouse_activity_icon.png", activity.clubhouse));
      activities.add(SizedBox(
        height: 20,
      ));
    }
    if (this.city.enabledPages.project) {
      activities.add(_activity(context, size, "Proyecto Docente",
          "assets/icons/project_activity_icon.png", activity.project));
      activities.add(SizedBox(
        height: 20,
      ));
    }

    return Column(
      children: activities,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
    );
  }

  Center _activity(
    BuildContext context,
    Size size,
    String name,
    String iconPath,
    String content,
  ) {
    return Center(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 32.0),
            width: size.width * 0.7,
            // color: Colors.white,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(
                    name.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: this.city.color),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12,
                  ),
                  child: Markdown2222(
                    data: content,
                    color: Colors2222.black,
                    contentAlignment: WrapAlignment.center,
                  ),
                ),
              ],
            ),
          ),

          /// icon position
          Positioned(
            left: 1,
            right: 1,
            child: Image.asset(
              iconPath,
              alignment: Alignment.topCenter,
            ),
          ),
        ],
      ),
    );
  }
}
