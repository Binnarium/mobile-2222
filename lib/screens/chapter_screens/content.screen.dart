import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/VideoPodcast.model.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/screens/chapter_screens/resources.screen.dart';
import 'package:lab_movil_2222/services/load-contents-screen-information.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/shared/widgets/podcast_audioPlayer_widget.dart';
import 'package:lab_movil_2222/shared/widgets/videoPlayer_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ContentScreen extends StatefulWidget {
  static const String route = '/contenido';
  final CityDto city;

  const ContentScreen({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  List<ContentDto>? contents;

  @override
  void initState() {
    super.initState();

    ILoadOptions<List<ContentDto>, CityDto> loader =
        LoadContentsScreenInformationService(
      chapterSettings: this.widget.city,
    );
    loader.load().then((value) => this.setState(() => contents = value));
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.pushNamed(
        context,
        ResourcesScreen.route,
        arguments: ResourcesScreen(
          cityDto: this.widget.city,
        ),
      );
      this.dispose();
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
            showStageLogo: true,
            city: this.widget.city,
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
    final double sidePadding = size.width * 0.08;

    if (contents == null)
      return Center(
        child: AppLoading(),
      );
    else
      return Column(
        children: [
          for (ContentDto c in this.contents!) ...[
            if (c is VideoContentDto) ...[
              Padding(
                padding: EdgeInsets.only(
                  bottom: 32,
                ),
                child: _titleContainer(size, c.author, c.title, " - vídeo"),
              ),

              /// text content
              Padding(
                padding: EdgeInsets.only(
                  right: sidePadding,
                  left: sidePadding,
                  bottom: 32,
                ),
                child: Markdown2222(data: c.description),
              ),

              /// video container
              Padding(
                padding: EdgeInsets.only(
                  right: sidePadding,
                  left: sidePadding,
                  bottom: 32,
                ),
                child: VideoPlayer(
                  video: c.content,
                  color: widget.city.color,
                ),
              ),
            ] else if (c is PodcastContentDto) ...[
              _titleContainer(size, c.author, c.title, " - podcast"),
              PodcastAudioPlayer(
                audioUrl: c.content.url,
                description: c.description,
                color: widget.city.color,
              ),
            ],
          ],
        ],
      );
  }

  _titleContainer(Size size, String? author, String? title, String kind) {
    return Container(
      color: Colors2222.white,
      width: double.infinity,
      padding:
          EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                  text: (author == null)
                      ? 'No author available'
                      : author.toUpperCase(),
                  style: korolevFont.subtitle1?.apply(
                    color: Colors.black,
                  ),
                  children: [
                TextSpan(
                  text: kind.toUpperCase(),
                  style: korolevFont.subtitle2?.apply(
                    color: Colors.black45,
                  ),
                )
              ])),
          SizedBox(
            height: 10,
          ),
          Text(
            (title == null) ? 'No title Available' : title.toUpperCase(),
            style: korolevFont.headline6?.apply(
              color: widget.city.color,
            ),
          ),
        ],
      ),
    );
  }
}
