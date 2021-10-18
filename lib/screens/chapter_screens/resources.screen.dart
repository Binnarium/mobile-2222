import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/models/city-resources.dto.dart';
import 'package:lab_movil_2222/services/load-city-resources.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-title-section.dart';
import 'package:lab_movil_2222/shared/widgets/online-resources-grid-item_widget.dart';
import 'package:lab_movil_2222/shared/widgets/reading-item.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({
    Key? key,
    required this.city,
  }) : super(key: key);

  static const String route = '/resources';

  final CityModel city;

  @override
  _ResourcesScreenState createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  CityResourcesDto? resourcesDto;
  StreamSubscription? _loadResourcesSub;

  @override
  void initState() {
    super.initState();

    final LoadCityResourcesService loadResourcesService =
        Provider.of<LoadCityResourcesService>(context, listen: false);

    _loadResourcesSub = loadResourcesService.load$(widget.city).listen(
      (cityResources) {
        if (mounted) {
          setState(() {
            resourcesDto = cityResources;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _loadResourcesSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold2222.city(
      city: widget.city,
      // ignore: prefer_const_literals_to_create_immutables
      backgrounds: [BackgroundDecorationStyle.topLeft],
      route: ResourcesScreen.route,
      body: _resourcesContent(size),
    );
  }

  ///body of the screen
  ListView _resourcesContent(Size size) {
    final double sidePadding = size.width * 0.04;

    ///sizing the container to the mobile
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: LogosHeader(
            showStageLogoCity: widget.city,
          ),
        ),
        if (resourcesDto == null)
          const AppLoading()
        else ...[
          /// readings title screen widgets
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ChapterTitleSection(
              title: 'LECTURAS',
            ),
          ),

          /// readings
          for (ReadingDto reading in resourcesDto!.readings)
            Padding(
              padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 20),
              child: ReadingItem(readingDto: reading),
            ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: ChapterTitleSection(
              title: 'RECURSOS ONLINE',
            ),
          ),

          /// external links

          Column(
            children: [
              for (ExternalLinkDto item in resourcesDto!.externalLinks)
                Padding(
                  padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 20),
                  child: ExternalLinkCard(externalLinkDto: item),
                ),
            ],
          ),
        ],
      ],
    );
  }
}
