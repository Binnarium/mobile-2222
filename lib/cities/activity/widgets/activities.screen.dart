import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/activity/model/city-activity.model.dart';
import 'package:lab_movil_2222/cities/activity/services/load-activity.service.dart';
import 'package:lab_movil_2222/home-map/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/services/cities-navigation.service.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

import 'activity-card.widget.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({
    Key? key,
    required this.city,
  }) : super(key: key);

  static const String route = '/activities';

  final CityModel city;

  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  CityActivityModel? _activity;
  StreamSubscription? _loadActivitiesSub;
  @override
  void initState() {
    super.initState();

    /// to load activities using provider
    final LoadCityActivitiesService loadActivitiesService =
        Provider.of<LoadCityActivitiesService>(context, listen: false);

    /// loading stream
    _loadActivitiesSub = loadActivitiesService.load$().listen(
      (cityActivityModel) {
        if (mounted) {
          setState(() {
            _activity = cityActivityModel;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _loadActivitiesSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double sidePadding = size.width * 0.08;
    return Scaffold2222.city(
      city: widget.city,
      backgrounds: const [BackgroundDecorationStyle.topLeft],
      route: ActivitiesScreen.route,
      body: ListView(
        children: [
          /// dead widget
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: LogosHeader(
              showStageLogoCity: widget.city,
            ),
          ),

          /// title
          Text(
            'Actividades'.toUpperCase(),
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),

          /// activities card
          if (_activity == null)
            const AppLoading()
          else ...[
            /// contribution card
            if (widget.city.enabledPages.enableContribution)
              Padding(
                padding: EdgeInsets.only(
                  top: 12,
                  left: sidePadding,
                  right: sidePadding,
                ),
                child: ActivityCardWidget(
                  color: widget.city.color,
                  content: _activity!.contribution,
                  iconPath: 'assets/icons/multiple_choice_activity_icon.png',
                  onTap: () =>
                      CityNavigator.getContributionNextScreen(widget.city)
                          .builder(context),
                  title: 'Manifiesto-wiki por la Educación',
                ),
              ),

            /// clubhouse event
            if (widget.city.enabledPages.enableClubhouse)
              Padding(
                padding: EdgeInsets.only(
                  top: 24,
                  left: sidePadding,
                  right: sidePadding,
                ),
                child: ActivityCardWidget(
                  color: widget.city.color,
                  content: _activity!.clubhouse,
                  iconPath: 'assets/icons/clubhouse_activity_icon.png',
                  onTap: () => CityNavigator.getCLubhouseNextScreen(widget.city)
                      .builder(context),
                  title: 'Eventos Clubhouse',
                ),
              ),

            /// project
            if (widget.city.enabledPages.enableProject)
              Padding(
                padding: EdgeInsets.only(
                  top: 24,
                  left: sidePadding,
                  right: sidePadding,
                ),
                child: ActivityCardWidget(
                  color: widget.city.color,
                  content: _activity!.project,
                  iconPath: 'assets/icons/project_activity_icon.png',
                  onTap: () => CityNavigator.getProjectNextScreen(widget.city)
                      .builder(context),
                  title: 'Proyecto Docente',
                ),
              ),
          ],

          /// end page padding
          const SizedBox(height: 24)
        ],
      ),
    );
  }
}
