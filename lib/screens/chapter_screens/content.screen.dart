import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/audio/ui/audio-player.widget.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/models/content-dto.dto.dart';
import 'package:lab_movil_2222/services/load-contents-screen-information.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/videoPlaceholder.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({
    Key? key,
    required CityModel city,
  })  : city = city,
        super(key: key);

  static const String route = '/contenido';
  final CityModel city;

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  List<ContentDto>? contents;
  StreamSubscription? _loadContentsSub;

  @override
  void initState() {
    super.initState();

    final LoadContentsScreenInformationService loadContentsService =
        Provider.of<LoadContentsScreenInformationService>(context,
            listen: false);

    // loadContentsService.load$(widget.city);
    _loadContentsSub = loadContentsService.load$(widget.city).listen(
      (cityContents) {
        if (mounted) {
          setState(() {
            contents = cityContents;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _loadContentsSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold2222.city(
      city: widget.city,
      // ignore: prefer_const_literals_to_create_immutables
      backgrounds: [BackgroundDecorationStyle.topRight],
      route: ContentScreen.route,
      body: _stageVideoContent(size, context),
    );
  }

  SizedBox _stageVideoContent(Size size, BuildContext context) {
    ///sizing the container to the mobile
    return SizedBox(
      /// builds an initial Listview with the banner at first element
      child: ListView(
        children: [
          ///calls the head of the chapter (logo leaf, banner)
          LogosHeader(
            showStageLogoCity: widget.city,
          ),
          const SizedBox(height: 20),

          /// method that makes the query from firestore who brings the whole content
          _pageContent(size),
        ],
      ),
    );
  }

  /// method that returns List<Widget> from firestore depending on content (video, podcast)
  RenderObjectWidget _pageContent(Size size) {
    final double sidePadding = size.width * 0.08;

    if (contents == null) {
      return const Center(
        child: AppLoading(),
      );
    } else {
      return Column(
        children: [
          for (ContentDto c in contents!) ...[
            if (c is VideoContentDto) ...[
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 32,
                ),
                child: _titleContainer(size, c.author, c.title, ' - vídeo'),
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
                child: VideoPlaceholderWidget(
                  video: c.content,
                ),
              ),
            ] else if (c is PodcastContentDto) ...[
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 32,
                ),
                child: _titleContainer(size, c.author, c.title, ' - podcast'),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: sidePadding,
                  left: sidePadding,
                  bottom: 32,
                ),
                child: Markdown2222(data: c.description),
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
  }

  Container _titleContainer(
      Size size, String? author, String? title, String kind) {
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
          const SizedBox(
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
