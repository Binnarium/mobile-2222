import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/models/content-dto.dto.dart';
import 'package:lab_movil_2222/services/load-contents-screen-information.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/shared/widgets/podcast_audioPlayer_widget.dart';
import 'package:lab_movil_2222/shared/widgets/scaffold-2222.widget.dart';
import 'package:lab_movil_2222/shared/widgets/videoPlayerTest.dart';
import 'package:lab_movil_2222/shared/widgets/videoPlayer_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ContentScreen extends StatefulWidget {
  static const String route = '/contenido';
  final CityDto city;
  final ILoadOptions<List<ContentDto>, CityDto> loader;

  ContentScreen({
    Key? key,
    required CityDto city,
  })  : this.city = city,
        this.loader = LoadContentsScreenInformationService(
          chapterSettings: city,
        ),
        super(key: key);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  List<ContentDto>? contents;
  @override
  void initState() {
    super.initState();

    this
        .widget
        .loader
        .load()
        .then((value) => this.setState(() => contents = value));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold2222(
      city: this.widget.city,
      backgrounds: [BackgroundDecoration.topRight],
      route: ContentScreen.route,
      body: _stageVideoContent(size, context),
    );
  }

  _stageVideoContent(Size size, BuildContext context) {
    ///sizing the container to the mobile
    return Container(
      /// builds an initial Listview with the banner at first element
      child: ListView(
        children: [
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
                // child: VideoPlayer(
                //   video: c.content,
                //   color: widget.city.color,
                // ),
                /// asking if its running on web (since web is not supported in VideoPlayerTest)
                child: (!kIsWeb)
                    ? VideoPlayerTest(
                        video: c.content,
                      )
                    : VideoPlayer(
                        video: c.content,
                        color: widget.city.color,
                      ),
              ),
            ] else if (c is PodcastContentDto) ...[
              Padding(
                padding: EdgeInsets.only(
                  bottom: 32,
                ),
                child: _titleContainer(size, c.author, c.title, " - podcast"),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: sidePadding,
                  left: sidePadding,
                  bottom: 32,
                ),
                child: (c.description == null)
                    ? Text('No description Available')
                    : Markdown2222(data: c.description),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sidePadding),
                child: PodcastAudioPlayer(
                  audio: c.content,
                  color: widget.city.color,
                ),
              ),
            ],
          ],
        ],
      );
  }

  _titleContainer(Size size, String? author, String? title, String kind) {
    final TextTheme textTheme = Theme.of(context).textTheme;
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
                  style: textTheme.subtitle1?.apply(
                    color: Colors.black,
                  ),
                  children: [
                TextSpan(
                  text: kind.toUpperCase(),
                  style: textTheme.subtitle2?.apply(
                    color: Colors.black45,
                  ),
                )
              ])),
          SizedBox(
            height: 10,
          ),
          Text(
            (title == null) ? 'No title Available' : title.toUpperCase(),
            style: textTheme.headline6?.apply(
              color: widget.city.color,
            ),
          ),
        ],
      ),
    );
  }
}
