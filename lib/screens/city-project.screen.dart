import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/models/project.model.dart';
import 'package:lab_movil_2222/services/load-project-activity.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/podcast_audioPlayer_widget.dart';

import 'chapter_screens/stageIntroduction.screen.dart';

class CityProjectScreen extends StatefulWidget {
  static const String route = '/project';

  final CityDto city;

  final ILoadInformationWithOptions<ProjectDto, CityDto> projectLoader;

  CityProjectScreen({
    Key? key,
    required this.city,
  })  : this.projectLoader = LoadProject(city: city),
        super(key: key);

  @override
  _CityProjectScreenState createState() => _CityProjectScreenState();
}

class _CityProjectScreenState extends State<CityProjectScreen> {
  ProjectDto? project;

  @override
  void initState() {
    super.initState();
    print('called');
    this
        .widget
        .projectLoader
        .load()
        .then((value) => this.setState(() => this.project = value));
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);

    VoidCallback? nextPage = this.widget.city.stage == 12
        ? null
        : () => Navigator.pushNamed(
              context,
              StageIntroductionScreen.route,
              arguments: StageIntroductionScreen(
                city: this.widget.city,
              ),
            );

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: GestureDetector(
        ///To make the horizontal scroll to the next or previous page.
        onPanUpdate: (details) {
          /// left
          if (details.delta.dx > 5) prevPage();

          /// right
          if (details.delta.dx < -5 && nextPage != null) nextPage();
        },
        child: Stack(
          children: [
            ChapterBackgroundWidget(
              backgroundColor: this.widget.city.color,
              reliefPosition: 'top-right',
            ),
            _routeCurve(),

            ///body of the screen

            _projectSheet(context, size, this.widget.city.color)
          ],
        ),
      )),
      bottomNavigationBar: CustomNavigationBar(
        prevPage: prevPage,
        nextPage: nextPage,
      ),
    );
  }

  _routeCurve() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Image(
        image: AssetImage(
          'assets/backgrounds/decorations/white_route_curve_background.png',
        ),
        color: Colors.white.withOpacity(0.25),
      ),
    );
  }

  _projectSheet(BuildContext context, Size size, Color color) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 50),
      children: [
        Center(
          child: Text(
            "PROYECTO PERSONAL",
            style: textTheme.headline4,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            "DE INNOVACIÓN DOCENTE",
            style: textTheme.headline5,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        if (this.project == null)
          IconLoading()
        else ...[
          Container(
            padding: EdgeInsets.only(right: 50),
            child: Text(
              this.project!.activity,
              style: textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 90,
          ),
          MarkdownBody(
            data: this.project!.explanation,
            styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
              textAlign: WrapAlignment.center,
            ),
          ),

          SizedBox(
            height: 20,
          ),

          /// if audio is available then show the audio player
          if (this.project!.audio != null) ...[
            Container(
              alignment: Alignment.center,
              child: PodcastAudioPlayer(
                audioUrl: this.project!.audio!.url,
                description: "",
                color: this.widget.city.color,
              ),
            ),
            SizedBox(
              height: 60,
            ),
          ],
          _taskButton(context, color)
        ],
      ],
    );
  }
}

_taskButton(BuildContext context, color) {
  double buttonWidth = MediaQuery.of(context).size.width;
  return Container(
    width: buttonWidth,
    margin: EdgeInsets.symmetric(horizontal: 40),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        elevation: 5,
      ),

      ///Navigates to main screen
      onPressed: () {},
      child: Text(
        'Subir Tarea',
      ),
    ),
  );
}

class IconLoading extends StatefulWidget {
  const IconLoading({
    Key? key,
  }) : super(key: key);

  @override
  _IconLoadingState createState() => _IconLoadingState();
}

class _IconLoadingState extends State<IconLoading>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      value: 0,
      lowerBound: 0,
      upperBound: 1,
    );

    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final double sideWidth = size.width * 0.3;

    return FadeTransition(
      opacity: _animation,
      child: AppLogo(
        kind: AppImage.loadingLogo,
        width: sideWidth,
        height: sideWidth,
        fit: BoxFit.contain,
      ),
    );
  }
}
