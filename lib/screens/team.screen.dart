import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/services/load-login-information.service.dart';
import 'package:lab_movil_2222/shared/models/Login.model.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';
import 'package:markdown/markdown.dart' as md;

class TeamScreen extends StatefulWidget {
  static const String route = '/equipo';

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  LoginDto? loginPayload;

  @override
  void initState() {
    super.initState();

    ILoadInformationService<LoginDto> loader = LoadLoginInformationService();
    loader
        .load()
        .then((value) => this.setState(() => this.loginPayload = value));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            ChapterBackgroundWidget(
              backgroundColor: ColorsApp.backgroundRed,
              reliefPosition: 'top-right',
            ),
            _routeCurve(),

            ///body of the screen
            _resourcesContent(context),
          ],
        ),
      ),
    );
  }

  ///body of the screen
  _resourcesContent(BuildContext context) {
    if (this.loginPayload == null)
      return Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(
            ColorsApp.backgroundRed,
          ),
        ),
      );

    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// back button to return previous page
          BackButton(color: Colors.white),

          /// page content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1,
              vertical: 24,
            ),
            child: TeamContentMarkdown(
              teamContent: this.loginPayload!.teamText,
            ),
          ),
        ],
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
}

/// Markdown content adapted to implement design guides, The team content is
/// mainly centered
class TeamContentMarkdown extends StatelessWidget {
  const TeamContentMarkdown({
    Key? key,
    required this.teamContent,
  }) : super(key: key);

  final String teamContent;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: this.teamContent,
      builders: {
        'h1': MarkdownHeadline1Builder(),
        'h2': MarkdownHeadline1Builder(),
      },
      styleSheet: MarkdownStyleSheet(
        p: korolevFont.bodyText2?.apply(fontSizeFactor: 1.1),
        h2Align: WrapAlignment.center,
        h2: korolevFont.headline4,
        h3Align: WrapAlignment.center,
        h3: korolevFont.headline6,
        orderedListAlign: WrapAlignment.center,
        listBullet: korolevFont.bodyText2?.apply(fontSizeFactor: 1.1),
      ),
    );
  }
}

class MarkdownHeadline1Builder extends MarkdownElementBuilder {
  @override
  Widget? visitText(md.Text element, TextStyle? preferredStyle) {
    print(element);
    return Container(
      color: Colors.amber,
      width: 200,
      height: 200,
      child: Text(element.text),
    );
  }
}
