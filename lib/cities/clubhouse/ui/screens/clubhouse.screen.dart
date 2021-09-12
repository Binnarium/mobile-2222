import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse-activity.model.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse.model.dart';
import 'package:lab_movil_2222/cities/clubhouse/services/load-available-clubhouse.service.dart';
import 'package:lab_movil_2222/cities/clubhouse/services/load-clubhouse-activity.service.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/screens/add-clubhouse.screen.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/widgets/clubhouse-event-card.widget.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/widgets/clubhouse-section-title.widget.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class ClubhouseScreen extends StatefulWidget {
  static const String route = '/chapterClubhouse';
  final CityDto city;

  const ClubhouseScreen({Key? key, required this.city}) : super(key: key);

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
    this.clubhousesSub =
        LoadAvailableClubhouseService(this.widget.city).listen((event) {
      this.setState(() {
        this.clubhouses = event;
      });
    });

    /// loads clubhouse
    LoadClubhouseService loadClubhouseActivityService =
        Provider.of<LoadClubhouseService>(this.context, listen: false);

    this._loadClubhousesActivitiesSub =
        loadClubhouseActivityService.load$(this.widget.city).listen(
      (clubhouseActivityModel) {
        if (this.mounted)
          this.setState(() {
            this.clubhouseActivity = clubhouseActivityModel;
          });
      },
    );
  }

  @override
  void deactivate() {
    this.clubhousesSub?.cancel();
    this._loadClubhousesActivitiesSub?.cancel();
    super.deactivate();
  }

  @override
  void dispose() {
    this.clubhousesSub?.cancel();
    this._loadClubhousesActivitiesSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold2222.city(
      city: this.widget.city,
      backgrounds: [BackgroundDecorationStyle.topRight],
      route: ClubhouseScreen.route,
      body: ListView(
        children: [
          /// icon item
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: LogosHeader(
              showStageLogoCity: this.widget.city,
            ),
          ),

          /// page header
          Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 24.0),
              width: min(300, size.width * 0.8),
              child: Text(
                "CLUBHOUSE".toUpperCase(),
                style: textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Center(
              child: Image(
                image: CoinsImages.clubhouse(),
                alignment: Alignment.bottomRight,
                fit: BoxFit.contain,
                width: min(160, size.width * 0.4),
              ),
            ),
          ),

          /// page content
          if (this.clubhouseActivity == null)
            AppLoading()
          else ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 34.0),
              child: Text(
                this.clubhouseActivity!.theme,
                style:
                    textTheme.headline5!.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ],

          /// next clubhouse title
          Padding(
            padding: const EdgeInsets.only(bottom: 34.0),
            child: ClubhouseSectionTitle(
              title: 'Eventos en las próximas 24 horas',
            ),
          ),

          /// page content
          (this.clubhouses == null)
              ? AppLoading()
              : Padding(
                  padding: EdgeInsets.only(
                    bottom: 20,
                    left: size.width * 0.04,
                    right: size.width * 0.04,
                  ),
                  child: (this.clubhouses!.length == 0)
                      ? Center(
                          child: Text(
                            'No hay clubhouse programados',
                            style: textTheme.headline6!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: size.width * 0.04,
                            mainAxisSpacing: size.width * 0.04,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: this.clubhouses!.length,
                          itemBuilder: (context, index) => ClubhouseCard(
                            clubhouseModel: this.clubhouses![index],
                          ),
                        ),
                ),

          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors2222.black,
                  elevation: 5,
                ),
                icon: Icon(Icons.add_rounded),
                label: Text('Agrega tu evento Clubhouse'),
                onPressed: () => Navigator.pushNamed(
                  context,
                  AddClubhouseScreen.route,
                  arguments: AddClubhouseScreen(
                    city: this.widget.city,
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
