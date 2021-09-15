import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city-resources.dto.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/services/load-city-resources.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-title-section.dart';
import 'package:lab_movil_2222/shared/widgets/online-resources-grid-item_widget.dart';
import 'package:lab_movil_2222/shared/widgets/reading-item.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class ResourcesScreen extends StatefulWidget {
  static const String route = '/resources';
  final CityModel city;

  ResourcesScreen({
    Key? key,
    required CityModel city,
  })  : this.city = city,
        super(key: key);

  @override
  _ResourcesScreenState createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  CityResourcesDto? resourcesDto;
  StreamSubscription? _loadResourcesSub;

  @override
  void initState() {
    super.initState();

    LoadCityResourcesService loadResourcesService =
        Provider.of<LoadCityResourcesService>(this.context, listen: false);

    this._loadResourcesSub =
        loadResourcesService.load$(this.widget.city).listen(
      (cityResources) {
        if (this.mounted)
          this.setState(() {
            this.resourcesDto = cityResources;
          });
      },
    );
  }

  @override
  void dispose() {
    this._loadResourcesSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold2222(
      city: this.widget.city,
      backgrounds: [BackgroundDecorationStyle.topLeft],
      route: ResourcesScreen.route,
      body: _resourcesContent(size),
    );
  }

  ///body of the screen
  _resourcesContent(Size size) {
    final double sidePadding = size.width * 0.04;

    ///sizing the container to the mobile
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: LogosHeader(
            showStageLogoCity: this.widget.city,
          ),
        ),
        if (this.resourcesDto == null)
          AppLoading()
        else ...[
          /// readings title screen widgets
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ChapterTitleSection(
              title: 'LECTURAS',
            ),
          ),

          /// readings
          for (ReadingDto reading in this.resourcesDto!.readings)
            Padding(
              padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 20),
              child: ReadingItem(readingDto: reading),
            ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: ChapterTitleSection(
              title: 'RECURSOS ONLINE',
            ),
          ),

          /// external links
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),

            ///Creates a grid with the necesary online resources
            child: StaggeredGridView.countBuilder(
              ///general spacing per resource
              crossAxisCount: 2,
              staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              itemCount: this.resourcesDto!.externalLinks.length,

              /// property that sizes the container automatically according
              /// the items
              shrinkWrap: true,

              ///to avoid the scroll
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = this.resourcesDto!.externalLinks.elementAt(index);
                // print(item);
                // print(item.kind);

                ///calls the custom widget with the item parameters
                if (item is ExternalLinkDto) {
                  return ExternalLinkCard(externalLinkDto: item);
                }

                return Text('Kind of content not found');
              },
            ),
          )
        ],
      ],
    );
  }
}
