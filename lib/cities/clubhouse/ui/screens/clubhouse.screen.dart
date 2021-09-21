import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse-activity.model.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse.model.dart';
import 'package:lab_movil_2222/cities/clubhouse/services/clubhouse.service.dart';
import 'package:lab_movil_2222/cities/clubhouse/services/load-available-clubhouse.service.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/screens/add-clubhouse.screen.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/widgets/clubhouse-event-card.widget.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/widgets/clubhouse-section-title.widget.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class ClubhouseScreen extends StatefulWidget {
  const ClubhouseScreen({Key? key, required this.city}) : super(key: key);

  static const String route = '/chapterClubhouse';

  final CityModel city;

  @override
  _ClubhouseScreenState createState() => _ClubhouseScreenState();
}

class _ClubhouseScreenState extends State<ClubhouseScreen> {
  StreamSubscription? clubhousesSub;
  StreamSubscription? _loadClubhousesActivitiesSub;

  List<ClubhouseModel>? clubhouses;
  ClubhouseActivityModel? clubhouseActivity;

  @override
  void initState() {
    super.initState();
    clubhousesSub = LoadAvailableClubhouseService(widget.city).listen((event) {
      setState(() {
        clubhouses = event;
      });
    });

    /// loads clubhouse
    final ClubhouseActivityService loadClubhouseActivityService =
        Provider.of<ClubhouseActivityService>(context, listen: false);

    _loadClubhousesActivitiesSub =
        loadClubhouseActivityService.activity$(widget.city).listen(
      (clubhouseActivityModel) {
        if (mounted) {
          setState(() {
            clubhouseActivity = clubhouseActivityModel;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    clubhousesSub?.cancel();
    clubhousesSub = null;
    _loadClubhousesActivitiesSub?.cancel();
    _loadClubhousesActivitiesSub = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold2222.city(
      city: widget.city,
      // ignore: prefer_const_literals_to_create_immutables
      backgrounds: [BackgroundDecorationStyle.topRight],
      route: ClubhouseScreen.route,
      body: ListView(
        children: [
          /// icon item
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: LogosHeader(
              showStageLogoCity: widget.city,
            ),
          ),

          /// page header
          Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 24.0),
              width: min(300, size.width * 0.8),
              child: Text(
                'CLUBHOUSE'.toUpperCase(),
                style: textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Center(
              child: Image(
                image: const CoinsImages.clubhouse(),
                alignment: Alignment.bottomRight,
                fit: BoxFit.contain,
                width: min(160, size.width * 0.4),
              ),
            ),
          ),

          /// page content
          if (clubhouseActivity == null)
            const AppLoading()
          else ...[
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.08,
                right: size.width * 0.08,
                bottom: 40,
              ),
              child: Text(
                clubhouseActivity!.thematic,
                style: textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
          ],

          /// next clubhouse title
          const Padding(
            padding: EdgeInsets.only(bottom: 34.0),
            child: ClubhouseSectionTitle(
              title: 'Eventos en las próximas 24 horas',
            ),
          ),

          /// page content
          if (clubhouses == null)
            const AppLoading()
          else
            Padding(
              padding: EdgeInsets.only(
                bottom: 20,
                left: size.width * 0.04,
                right: size.width * 0.04,
              ),
              child: (clubhouses!.isEmpty)
                  ? Center(
                      child: Text(
                        'No hay clubhouse programados',
                        style: textTheme.headline6!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: size.width * 0.04,
                        mainAxisSpacing: size.width * 0.04,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: clubhouses!.length,
                      itemBuilder: (context, index) => ClubhouseCard(
                        clubhouseModel: clubhouses![index],
                      ),
                    ),
            ),

          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors2222.black,
                  elevation: 5,
                ),
                icon: const Icon(Icons.add_rounded),
                label: const Text('Agrega tu evento Clubhouse'),
                onPressed: () => Navigator.pushNamed(
                  context,
                  AddClubhouseScreen.route,
                  arguments: AddClubhouseScreen(
                    city: widget.city,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
