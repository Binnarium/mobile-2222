import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/city.dto.dart';

class ActivitiesWidget extends StatelessWidget {
  final CityDto chapterSettings;
  const ActivitiesWidget({
    Key? key,
    required this.chapterSettings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> activities = [];
    if (this.chapterSettings.enabledPages.clubhouse) {
      activities.add(_activity(context, size, "Eventos Clubhouse",
          "assets/icons/clubhouse_activity_icon.png"));
      activities.add(SizedBox(
        height: 20,
      ));
    }
    if (this.chapterSettings.enabledPages.questionary) {
      activities.add(_activity(context, size, "Cuestionario",
          "assets/icons/multiple_choice_activity_icon.png"));
      activities.add(SizedBox(
        height: 20,
      ));
    }
    if (this.chapterSettings.enabledPages.project) {
      activities.add(_activity(context, size, "Proyecto Docente",
          "assets/icons/project_activity_icon.png"));
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
  ) {
    return Center(
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                width: size.width * 0.7,
                height: (size.height > 800)
                    ? size.height * 0.15
                    : (size.height < 570)
                        ? size.height * 0.3
                        : size.height * 0.2,
                // color: Colors.white,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        name.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: this.chapterSettings.color),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Tenim ipsam voluptaem quia voluptas sit aspe natur aut odit fugit sed quia",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
