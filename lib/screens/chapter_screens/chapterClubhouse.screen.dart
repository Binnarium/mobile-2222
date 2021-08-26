import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/services/load-cities-settings.service.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-subtitle-section.dart';
import 'package:lab_movil_2222/shared/widgets/club-resources-grid-item_widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

class ChapterClubhouseScreen extends StatefulWidget {
  static const String route = '/chapterClubhouse';
  final CityDto chapterSettings;

  const ChapterClubhouseScreen({Key? key, required this.chapterSettings})
      : super(key: key);

  @override
  _ChapterClubhouseScreenState createState() => _ChapterClubhouseScreenState();
}

class _ChapterClubhouseScreenState extends State<ChapterClubhouseScreen> {
  late List<CityDto> chapters;
  @override
  void initState() {
    super.initState();
    ILoadInformationService<List<CityDto>> loader = LoadCitiesSettingService();
    loader.load().then((value) => this.setState(() => this.chapters = value));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold2222(
      city: this.widget.chapterSettings,
      backgrounds: [BackgroundDecorationStyle.topRight],
      route: ChapterClubhouseScreen.route,
      body: _resourcesContent(size),
    );
  }

  ///body of the screen
  _resourcesContent(Size size) {
    ///sizing the container to the mobile
    return Container(
      ///Listview of the whole screen
      child: ListView(
        children: [
          ChapterHeadWidget(
            showStageLogo: true,
            city: this.widget.chapterSettings,
          ),
          SizedBox(
            height: 50,
          ),
          _titleClub(size),
          SizedBox(
            height: 10,
          ),
          _bodyClub(size),
          SizedBox(
            height: 20,
          ),
          ChapterSubtitleSection(
            title: 'PRÓXIMOS ENCUENTROS',
          ),
          SizedBox(
            height: 35,
          ),

          ///calling the body of online resources, expected a json
          _onlineResourcesBody(size, [
            2,
            3,
            2,
            1,
            2,
          ]),
        ],
      ),
    );
  }

  _titleClub(Size size) {
    String texto = 'CLUBHOUSE';

    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      child: Text(
        texto,
        style: textTheme.headline2,
        textAlign: TextAlign.center,
      ),
    );
  }

  _bodyClub(Size size) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    String texto =
        'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto.';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Text(
        texto,
        style: textTheme.bodyText2,
        textAlign: TextAlign.center,
      ),
    );
  }

  ///Method of the online resources
  _onlineResourcesBody(Size size, List list) {
    ///main container
    return Container(
      ///To resize the parent container of the online resources grid

      margin: EdgeInsets.symmetric(horizontal: 5),

      ///Creates a grid with the necesary online resources
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15, mainAxisExtent: (size.height > 700) ? 200 : 180,
          // childAspectRatio: 1,
        ),
        itemCount: list.length,

        /// property that sizes the container automaticly according
        /// the items
        shrinkWrap: true,

        ///to avoid the scroll
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          ///calls the custom widget with the item parameters
          return ClubResourcesGridItem(
              theme: 'TEMA DEL ENCUENTRO',
              schedule: 'LUNES 12/06 // 13:30 HS.',
              agenda: 'AÑADIR A MI AGENDA');
        },
      ),
    );
  }
}
