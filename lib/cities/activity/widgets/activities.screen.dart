import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/activity/model/city-activity.model.dart';
import 'package:lab_movil_2222/cities/activity/services/load-activity.service.dart';
import 'package:lab_movil_2222/cities/activity/widgets/activiy_container_widget.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/scaffold-2222.widget.dart';

class ActivitiesScreen extends StatefulWidget {
  static const String route = '/activities';

  final ILoadOptions<CityActivityModel, CityDto> manualLoader;

  final CityDto city;

  ActivitiesScreen({
    Key? key,
    required CityDto city,
  })  : this.city = city,
        this.manualLoader = LoadCityService(city: city),
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
    return Scaffold2222(
      city: this.widget.city,
      backgrounds: [BackgroundDecoration.topLeft],
      route: ActivitiesScreen.route,
      body: _activitiesContent(context, size),
    );
  }

  _activitiesContent(BuildContext context, Size size) {
    /// sizing the container to the mobile
    return Container(
      /// Listview of the whole screen
      child: ListView(
        // physics: NeverScrollableScrollPhysics(),
        children: [
          ChapterHeadWidget(
            showStageLogo: true,
            city: this.widget.city,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Text(
              'Actividades'.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .apply(fontSizeFactor: 0.8),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // _activitiesCircle(size),
          this.activity == null ? AppLoading() : _activitiesBody(size),
        ],
      ),
    );
  }

  _activitiesBody(Size size) {
    return ActivitiesWidget(city: widget.city, activity: activity!);
  }
}
