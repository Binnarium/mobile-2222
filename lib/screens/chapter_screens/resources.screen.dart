import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city-resources.dto.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/screens/chapter_screens/activities.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/chapterClubhouse.screen.dart';
import 'package:lab_movil_2222/services/load-city-resources.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-title-section.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/online-resources-grid-item_widget.dart';
import 'package:lab_movil_2222/shared/widgets/reading-item.widget.dart';

class ResourcesScreen extends StatefulWidget {
  static const String route = '/resources';
  final CityDto city;

  final ILoadOptions<CityResourcesDto, CityDto> resourcesLoader;

  ResourcesScreen({
    Key? key,
    required CityDto city,
  })  : this.city = city,
        this.resourcesLoader = LoadCityResourcesService(city: city),
        super(key: key);

  @override
  _ResourcesScreenState createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  CityResourcesDto? resourcesDto;

  @override
  void initState() {
    super.initState();

    this
        .widget
        .resourcesLoader
        .load()
        .then((value) => this.setState(() => this.resourcesDto = value));
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = (this.widget.city.enabledPages.activities)
        ? () {
            Navigator.pushNamed(
              context,
              ActivitiesScreen.route,
              arguments: ActivitiesScreen(
                chapterSettings: this.widget.city,
              ),
            );
          }
        : () {
            Navigator.pushNamed(
              context,
              ChapterClubhouseScreen.route,
              arguments: ChapterClubhouseScreen(
                chapterSettings: this.widget.city,
              ),
            );
          };
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: GestureDetector(
          ///To make the horizontal scroll to the next or previous page.
          onPanUpdate: (details) {
            /// left
            if (details.delta.dx > 5) prevPage();

            /// right
            if (details.delta.dx < -5) nextPage();
          },
          child: Stack(
            children: [
              ChapterBackgroundWidget(
                backgroundColor: widget.city.color,
              ),

              ///body of the screen
              _resourcesContent(size),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        nextPage: nextPage,
        prevPage: prevPage,
      ),
    );
  }

  ///body of the screen
  _resourcesContent(Size size) {
    final double sidePadding = size.width * 0.04;

    ///sizing the container to the mobile
    return ListView(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ChapterHeadWidget(
            showStageLogo: true,
            city: this.widget.city,
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
                print(item);
                print(item.kind);

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
