import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/Lecture.model.dart';
import 'package:lab_movil_2222/models/OnlineResource.model.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/screens/chapter_screens/activities.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/chapterClubhouse.screen.dart';
import 'package:lab_movil_2222/services/load-resources-screen-information.service.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-title-section.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/lectures-list-item_widget.dart';
import 'package:lab_movil_2222/shared/widgets/online-resources-grid-item_widget.dart';

class ResourcesScreen extends StatefulWidget {
  static const String route = '/resources';
  final CityDto cityDto;

  const ResourcesScreen({
    Key? key,
    required this.cityDto,
  }) : super(key: key);

  @override
  _ResourcesScreenState createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  List<ResourcesDto>? onlineResources;
  List<LecturesDto>? readings;

  @override
  void initState() {
    super.initState();

    ILoadInformationWithOptions<List<dynamic>, CityDto> resourcesLoader =
        LoadOnlineResourcesScreenInformationService(
      chapterSettings: this.widget.cityDto,
    );

    resourcesLoader.load().then((value) =>
        this.setState(() => onlineResources = value as List<ResourcesDto>));

    ILoadInformationWithOptions<List<dynamic>, CityDto> readingsLoader =
        LoadReadingsResourcesScreenInformationService(
      chapterSettings: this.widget.cityDto,
    );
    readingsLoader.load().then(
        (value) => this.setState(() => readings = value as List<LecturesDto>));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = (this.widget.cityDto.enabledPages.activities)
        ? () {
            Navigator.pushNamed(
              context,
              ActivitiesScreen.route,
              arguments: ActivitiesScreen(
                chapterSettings: this.widget.cityDto,
              ),
            );
          }
        : () {
            Navigator.pushNamed(
              context,
              ChapterClubhouseScreen.route,
              arguments: ChapterClubhouseScreen(
                chapterSettings: this.widget.cityDto,
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
                backgroundColor: widget.cityDto.color,
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
    ///sizing the container to the mobile
    return Container(
      ///Listview of the whole screen
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          ChapterHeadWidget(
            showStageLogo: true,
            city: this.widget.cityDto,
          ),
          SizedBox(
            height: 20,
          ),

          ///chapter title screen widgets
          ChapterTitleSection(
            title: 'LECTURAS',
          ),
          SizedBox(
            height: 20,
          ),

          ///list of the bodys (json expected)
          _booksBody(size),
          SizedBox(height: 30),
          ChapterTitleSection(
            title: 'RECURSOS ONLINE',
          ),
          SizedBox(
            height: 40,
          ),

          ///calling the body of online resources, expected a json
          _onlineResourcesBody(size),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  /// books body method
  _booksBody(Size size) {
    if (this.readings == null)
      return Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(
            Colors.white,
          ),
        ),
      );

    /// main container
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),

      ///To resize the parent container of the list of books

      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: readings!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final item = readings!.elementAt(index);

            ///calls the custom widget with the item parameters

            return LecturesListItem(
              title: item.name!,
              author: item.author!,
              year: item.publishedDate!,
              size: size,
              link: item.link,
              review: item.about,
              hasLineBehind: (index == (readings!.length - 1)) ? false : true,
              imageURL: item.coverUrl,
            );
          }),
    );
  }

  ///Method of the online resources
  _onlineResourcesBody(Size size) {
    if (this.readings == null)
      return Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(
            Colors.white,
          ),
        ),
      );

    ///main container
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),

      ///To resize the parent container of the online resources grid

      ///Creates a grid with the necesary online resources
      child: StaggeredGridView.countBuilder(
        ///general spacing per resource
        crossAxisCount: 2,

        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
        itemCount: onlineResources!.length,

        /// property that sizes the container automaticly according
        /// the items
        shrinkWrap: true,

        ///to avoid the scroll
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = onlineResources!.elementAt(index);
          print(item);
          print(item.kind);

          ///calls the custom widget with the item parameters
          if (item is OnlineResourceDto) {
            return OnlineResourcesGridItem(
              color: widget.cityDto.color,
              size: size,
              name: item.name!,
              kind: item.kind!,
              description: item.description,
              redirect: item.redirect,
            );
          }
          return Text('Kind of content not found');
        },
      ),
    );
  }
}
