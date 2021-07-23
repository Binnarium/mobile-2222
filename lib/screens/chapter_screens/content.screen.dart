import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/resources.screen.dart';
import 'package:lab_movil_2222/services/i-load-content.service.dart';
import 'package:lab_movil_2222/services/load-contents-screen-information.service.dart';
import 'package:lab_movil_2222/shared/models/FirebaseChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/models/VideoPodcast.model.dart';
import 'package:lab_movil_2222/shared/widgets/videoPlayer_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/podcast_audioPlayer_widget.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ContentScreen extends StatefulWidget {
  static const String route = '/video';
  final FirebaseChapterSettings chapterSettings;

  const ContentScreen({Key? key, required this.chapterSettings})
      : super(key: key);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  List<ContentDto>? contents;

  @override
  void initState() {
    super.initState();

    ILoadContentService<List<dynamic>> loader =
        LoadContentsScreenInformationService();
    loader.loadWithSettings(this.widget.chapterSettings).then(
        (value) => this.setState(() => contents = value as List<ContentDto>));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.pushNamed(
        context,
        ResourcesScreen.route,
        arguments: ResourcesScreen(
          chapterSettings: this.widget.chapterSettings,
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
                backgroundColor: Color(widget.chapterSettings.primaryColor),
                reliefPosition: 'top-left',
              ),

              /// calls the method who brings the whole firestore query (List<Widget>)
              _stageVideoContent(size, context),
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

  _stageVideoContent(Size size, BuildContext context) {
    ///sizing the container to the mobile
    return Container(
      /// builds an initial Listview with the banner at first element
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),

          ///calls the head of the chapter (logo leaf, banner)
          ChapterHeadWidget(
            chapterName: this.widget.chapterSettings.cityName,
            phaseName: this.widget.chapterSettings.phaseName,
            chapterImgURL: this.widget.chapterSettings.chapterImageUrl,
          ),
          SizedBox(height: 20),

          /// method that makes the query from firestore who brings the whole content
          _pageContent(size),
        ],
      ),
    );
  }

  /// method that returns List<Widget> from firestore depending on content (video, podcast)
  _pageContent(Size size) {
    if (contents == null) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(
            Color(this.widget.chapterSettings.primaryColor),
          ),
        ),
      );
    }

    final List<Widget> contentWidgets = contents!.map<Widget>((c) {
      if (c is VideoDto)
        return Column(
          children: [
            _titleContainer(size, c.author, c.title, " - vídeo"),
            new VideoPlayerSegment(
              videoUrl: c.url!,
              description: c.description,
              color: Color(widget.chapterSettings.primaryColor),
            ),
          ],
        );
      if (c is PodcastDto)
        return Column(
          children: [
            _titleContainer(size, c.author, c.title, " - podcast"),
            PodcastAudioPlayer(
              audioUrl: c.url,
              description: c.description,
              color: Color(widget.chapterSettings.primaryColor),
            ),
          ],
        );
      throw ErrorDescription('Kind of content not found');
    }).toList();
    return Column(
      children: contentWidgets,
    );
  }

  _titleContainer(Size size, String? author, String? title, String kind) {
    return UnconstrainedBox(
      child: Container(
        color: Colors.white,
        width: size.width,
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    text: (author == null)
                        ? 'No author available'
                        : author.toUpperCase(),
                    style: korolevFont.headline5
                        ?.apply(color: Colors.black, fontSizeFactor: 0.7),
                    children: [
                  TextSpan(
                    text: kind.toUpperCase(),
                    style: korolevFont.headline5
                        ?.apply(color: Colors.black45, fontSizeFactor: 0.7),
                  )
                ])),
            SizedBox(
              height: 10,
            ),
            Text(
              (title == null) ? 'No title Available' : title.toUpperCase(),
              style: korolevFont.headline6?.apply(
                color: Color(widget.chapterSettings.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
