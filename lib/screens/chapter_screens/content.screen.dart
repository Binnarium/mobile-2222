import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/audio/ui/audio-player.widget.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/video-player.widget.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/models/content-dto.dto.dart';
import 'package:lab_movil_2222/services/load-contents-screen-information.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class ContentScreen extends StatefulWidget {
  static const String route = '/contenido';
  final CityModel city;

  ContentScreen({
    Key? key,
    required CityModel city,
  })  : this.city = city,
        super(key: key);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  List<ContentDto>? contents;
  StreamSubscription? _loadContentsSub;

  @override
  void initState() {
    super.initState();

    LoadContentsScreenInformationService loadContentsService =
        Provider.of<LoadContentsScreenInformationService>(this.context,
            listen: false);

    // loadContentsService.load$(this.widget.city);
    this._loadContentsSub = loadContentsService.load$(this.widget.city).listen(
      (cityContents) {
        if (this.mounted)
          this.setState(() {
            this.contents = cityContents;
          });
      },
    );
  }

  @override
  void dispose() {
    this._loadContentsSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold2222.city(
      city: this.widget.city,
      backgrounds: [BackgroundDecorationStyle.topRight],
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
          LogosHeader(
            showStageLogoCity: this.widget.city,
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

                  /// asking if its running on web (because web is not supported
                  /// in better_player package)
                  child: VideoPlayer(
                    video: c.content,
                  )),
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
                padding: EdgeInsets.only(
                  right: sidePadding,
                  left: sidePadding,
                  bottom: 32,
                ),
                child: AudioPlayerWidget(
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
