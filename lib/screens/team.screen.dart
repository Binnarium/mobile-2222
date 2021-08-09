import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/services/load-login-information.service.dart';
import 'package:lab_movil_2222/shared/models/Login.model.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
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
    final TextTheme textTheme = Theme.of(context).textTheme;

    return MarkdownBody(
      data: this.teamContent,
      builders: {
        'h2': MarkdownCenterHeadline(),
        'h3': MarkdownCenterHeadline(padding: EdgeInsets.only(top: 35)),
        'h4': MarkdownCenterHeadline(padding: EdgeInsets.only(top: 10)),
        'p': MarkdownCustomCreators(),
      },
      styleSheet: MarkdownStyleSheet(
        h2: textTheme.headline4,
        h3: textTheme.headline6,
        h4: textTheme.caption,
        p: textTheme.bodyText2,
      ),
    );
  }
}

class MarkdownCenterHeadline extends MarkdownElementBuilder {
  final EdgeInsets? padding;

  MarkdownCenterHeadline({
    this.padding,
  });

  @override
  Widget? visitText(md.Text element, TextStyle? preferredStyle) {
    return Container(
      padding: this.padding,
      width: double.infinity,
      child: Text(
        element.text.toUpperCase(),
        style: preferredStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class MarkdownCustomCreators extends MarkdownElementBuilder {
  @override
  Widget? visitText(md.Text element, TextStyle? preferredStyle) {
    final List<String> names =
        element.text.split(',').map((e) => e.trim()).toList();

    final List<Widget> colItems = [];

    for (int i = 0; i < names.length; i += 2) {
      final String nameOne = names[i];
      final String? nameTwo = (i + 1 >= names.length) ? null : names[i + 1];

      final Row row = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// add first name
          Expanded(
            child: Container(
              width: double.infinity,
              child: Text(
                nameOne,
                style: preferredStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: nameTwo == null ? TextAlign.center : TextAlign.right,
              ),
            ),
          ),

          /// add second name then found
          if (nameTwo != null) ...[
            SizedBox(
              width: 10,
            ),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                nameTwo,
                style: preferredStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              ),
            ),
          ]
        ],
      );

      colItems.add(row);

      /// add spacer between lines
      if (i + 1 < names.length)
        colItems.add(
          Container(
            height: 5,
          ),
        );
    }

    return Column(
      children: colItems,
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }
}
