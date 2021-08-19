import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/activiy_container_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/scaffold-2222.widget.dart';

class ActivitiesScreen extends StatelessWidget {
  static const String route = '/activities';
  final CityDto chapterSettings;

  const ActivitiesScreen({
    Key? key,
    required this.chapterSettings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold2222(
      city: this.chapterSettings,
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
          SizedBox(
            height: 10,
          ),
          ChapterHeadWidget(
            showStageLogo: true,
            city: this.chapterSettings,
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
          _activitiesBody(size),
        ],
      ),
    );
  }

  _activitiesBody(Size size) {
    return ActivitiesWidget(chapterSettings: chapterSettings);
  }
}
