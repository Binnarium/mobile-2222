import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/activities.screen.dart';
import 'package:lab_movil_2222/shared/models/ChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/models/Reading.model.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-title-section.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/lectures-list-item_widget.dart';
import 'package:lab_movil_2222/shared/widgets/online-resources-grid-item_widget.dart';

class ResourcesScreen extends StatefulWidget {
  static const String route = '/resources';
  final ChapterSettings chapterSettings;

  const ResourcesScreen({Key? key, required this.chapterSettings})
      : super(key: key);

  @override
  _ResourcesScreenState createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  @override
  void initState() {
    _readings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ActivitiesScreen(
          chapterSettings: this.widget.chapterSettings,
        );
      }));
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
                backgroundColor:
                    Color(int.parse(widget.chapterSettings.primaryColor)),
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
          ChapterHeadWidget(
            phaseName: this.widget.chapterSettings.phaseName,
            chapterName: this.widget.chapterSettings.cityName,
            chapterImgURL: this.widget.chapterSettings.chapterImageUrl,
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
          _onlineResourcesBody([
            2,
            3,
            2,
            1,
            2,
          ], size),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  /// books body method
  _booksBody(Size size) {
    double bodyMarginWidth = size.width * 0.05;

    /// main container
    return Container(
      /// general left padding 25
      margin: EdgeInsets.only(left: 25, right: bodyMarginWidth),

      ///To resize the parent container of the list of books

      child: FutureBuilder(
          future: _readings(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ReadingModel>> readings) {
            if (readings.hasError) {
              return Text(readings.error.toString());
            }

            if (readings.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color(int.parse(widget.chapterSettings.primaryColor)),
                  ),
                ),
              );
            }
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: readings.data?.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  ///bringing a book resource per item in the list
                  return LecturesListItem(
                      size: size,
                      imageURL: readings.data?[index].coverUrl.toString(),
                      title: readings.data![index].name.toString(),
                      author: readings.data![index].author.toString(),
                      year: readings.data![index].publishedDate.toString(),
                      review: readings.data![index].about.toString());
                });
          }),
    );
  }

  ///Method of the online resources
  _onlineResourcesBody(List list, Size size) {
    double bodyMarginWidth = size.width * 0.05;

    ///main container
    return Container(
      margin: EdgeInsets.only(left: 25, right: bodyMarginWidth),

      ///To resize the parent container of the online resources grid

      ///Creates a grid with the necesary online resources
      child: GridView.builder(
        ///general spacing per resource
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
          return OnlineResourcesGridItem(
              color: Color(int.parse(widget.chapterSettings.primaryColor)),
              size: size,
              account: 'Platzi/live',
              type: 'youtube',
              description:
                  'Tenim ipsam voluptatem quia voluptenim  quia voluptas sias sit aspernatur aut odit aut fugit,sed quia conseunde omnis iste natus error sit voluptatem accusantium doloremque');
        },
      ),
    );
  }

  Future<List<ReadingModel>> _readings() async {
    final List<ReadingModel> readingsListTemp = [];

    await FirebaseFirestore.instance.collection('readings').get().then(
      (QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach(
          (doc) {
            final readTemp = new ReadingModel(
              coverUrl: doc['coverUrl'],
              author: doc['author'],
              about: doc['about'],
              name: doc['name'],
              publishedDate: doc['publishedDate'].toString(),
              id: 'id',
            );
            print(readTemp.toJson());

            readingsListTemp.add(readTemp);
            // _readingsList.add(readTemp);
            print('Lo que viene de firebase: ${doc.data().toString()}');
          },
        );
      },
    );
    return readingsListTemp;
  }
}
