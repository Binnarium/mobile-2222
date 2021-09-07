import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/activity/model/city-activity.model.dart';
import 'package:lab_movil_2222/cities/activity/services/load-activity.service.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/screens/clubhouse.screen.dart';
import 'package:lab_movil_2222/cities/project-video/widgets/project-video.screen.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/screens/chapter_screens/city-contribution.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/city-project.screen.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

import 'activity-card.widget.dart';

class ActivitiesScreen extends StatefulWidget {
  static const String route = '/activities';

  final ILoadInformationService<CityActivityModel> manualLoader;

  final CityDto city;

  ActivitiesScreen({
    Key? key,
    required CityDto city,
  })  : this.city = city,
        this.manualLoader = LoadCityService(),
        super(key: key);

  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  CityActivityModel? activity;

  @override
  void initState() {
    super.initState();
    this
        .widget
        .manualLoader
        .load()
        .then((value) => this.setState(() => this.activity = value));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double sidePadding = size.width * 0.08;
    return Scaffold2222.city(
      city: this.widget.city,
      backgrounds: [BackgroundDecorationStyle.topLeft],
      route: ActivitiesScreen.route,
      body: ListView(
        children: [
          /// dead widget
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: LogosHeader(
              showStageLogoCity: this.widget.city,
            ),
          ),

          /// title
          Text(
            'Actividades'.toUpperCase(),
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),

          /// activities card
          if (this.activity == null)
            AppLoading()
          else ...[
            /// contribution card
            if (this.widget.city.enabledPages.contribution)
              Padding(
                padding: EdgeInsets.only(
                  top: 12,
                  left: sidePadding,
                  right: sidePadding,
                ),
                child: ActivityCardWidget(
                  color: this.widget.city.color,
                  content: this.activity!.contribution,
                  iconPath: "assets/icons/multiple_choice_activity_icon.png",
                  onTap: () => Navigator.pushNamed(
                    context,
                    YourContributionScreen.route,
                    arguments: YourContributionScreen(
                      city: this.widget.city,
                    ),
                  ),
                  title: "Manifiesto por la Educación",
                ),
              ),

            /// clubhouse event
            if (this.widget.city.enabledPages.clubhouse)
              Padding(
                padding: EdgeInsets.only(
                  top: 24,
                  left: sidePadding,
                  right: sidePadding,
                ),
                child: ActivityCardWidget(
                  color: this.widget.city.color,
                  content: this.activity!.clubhouse,
                  iconPath: "assets/icons/clubhouse_activity_icon.png",
                  onTap: () => Navigator.pushNamed(
                    context,
                    ClubhouseScreen.route,
                    arguments: ClubhouseScreen(
                      city: this.widget.city,
                    ),
                  ),
                  title: "Eventos Clubhouse",
                ),
              ),

            /// project
            if (this.widget.city.enabledPages.project)
              Padding(
                padding: EdgeInsets.only(
                  top: 24,
                  left: sidePadding,
                  right: sidePadding,
                ),
                child: ActivityCardWidget(
                  color: this.widget.city.color,
                  content: this.activity!.project,
                  iconPath: "assets/icons/project_activity_icon.png",
                  onTap: () {
                    final List<Function> actions = [
                      /// TODO: THIS MIGHT NOT BE NECESSARY
                      /// navigate to project screen if enabled
                      if (this.widget.city.enabledPages.project)
                        () => Navigator.pushNamed(
                              context,
                              CityProjectScreen.route,
                              arguments: CityProjectScreen(
                                city: this.widget.city,
                              ),
                            ),

                      /// navigate to project video screen if enabled
                      if (this.widget.city.enabledPages.projectVideo)
                        () => Navigator.pushNamed(
                              context,
                              ProjectVideoScreen.route,
                              arguments: ProjectVideoScreen(
                                city: this.widget.city,
                              ),
                            ),

                      /// default void function
                      () {}
                    ];
                    actions.first();
                  },
                  title: "Proyecto Docente",
                ),
              ),
          ],

          /// end page padding
          SizedBox(height: 24)
        ],
      ),
    );
  }
}
