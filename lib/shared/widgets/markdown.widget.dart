import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as fmd;
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';
import 'package:markdown/markdown.dart' as md;

@Deprecated('use the Markdown2222 instead')
typedef Markdown = Markdown2222;

class Markdown2222 extends StatelessWidget {
  final String data;
  final Color color;

  const Markdown2222({
    Key? key,
    required this.data,
    this.color = Colors2222.white,
    this.contentAlignment,
  }) : super(key: key);

  final WrapAlignment? contentAlignment;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith(
      textTheme: KorolevFont(textColor: this.color),
    );

    return fmd.MarkdownBody(
      data: this.data,
      styleSheet: fmd.MarkdownStyleSheet.fromTheme(theme).copyWith(
        h1Align: this.contentAlignment,
        h2Align: this.contentAlignment,
        h3Align: this.contentAlignment,
        h4Align: this.contentAlignment,
        h5Align: this.contentAlignment,
        h6Align: this.contentAlignment,
        textAlign: this.contentAlignment,
        blockSpacing: 20,
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

    return fmd.MarkdownBody(
      data: this.teamContent,
      builders: {
        'h2': _MarkdownCenterText(),
        'h3': _MarkdownCenterText(padding: EdgeInsets.only(top: 36)),
        'h4': _MarkdownCenterText(padding: EdgeInsets.only(top: 16)),
        'p': _MarkdownCustomCreators(),
      },
      styleSheet: fmd.MarkdownStyleSheet(
        h2: textTheme.headline4!.copyWith(fontWeight: FontWeight.w500),
        h3: textTheme.headline5!.copyWith(fontWeight: FontWeight.w500),
        h4: textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w400),
        p: textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

///
///
///
class ContributionContentMarkdown extends StatelessWidget {
  const ContributionContentMarkdown({
    Key? key,
    required this.contributionContent,
  }) : super(key: key);

  final String contributionContent;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return fmd.MarkdownBody(
      data: this.contributionContent,
      builders: {
        'h2': _MarkdownCenterText(),
        'h3': _MarkdownCenterText(padding: EdgeInsets.only(top: 35)),
        'h4': _MarkdownCenterText(padding: EdgeInsets.only(top: 10)),
        'p': _MarkdownCustomCreators(),
      },
      styleSheet: fmd.MarkdownStyleSheet(
        h2: textTheme.headline3!.apply(fontWeightDelta: 10),
        h3: textTheme.headline5,
        h4: textTheme.caption,
        p: textTheme.subtitle1,
      ),
    );
  }
}

///
///
///
class MarkdownCard extends StatelessWidget {
  final String workload;

  const MarkdownCard({
    Key? key,
    required this.workload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).primaryTextTheme;
    final Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Colors2222.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(size.width * 0.1),
      child: fmd.MarkdownBody(
        data: this.workload,
        builders: {
          'h2': _MarkdownCenterText(padding: EdgeInsets.symmetric(vertical: 8)),
          'h3': _MarkdownCenterText(padding: EdgeInsets.symmetric(vertical: 4)),
          'p': _MarkdownCenterText(padding: EdgeInsets.symmetric(vertical: 4)),
        },
        styleSheet: fmd.MarkdownStyleSheet(
          h2: textTheme.subtitle1,
          h3: textTheme.subtitle1!.apply(color: Colors2222.red),
          p: textTheme.bodyText2,
        ),
      ),
    );
  }
}

/// utility to center markdown text
class _MarkdownCenterText extends fmd.MarkdownElementBuilder {
  final EdgeInsets? padding;

  _MarkdownCenterText({
    this.padding,
  });

  @override
  Widget? visitText(md.Text element, TextStyle? preferredStyle) {
    return Container(
      padding: this.padding,
      width: double.infinity,
      child: Text(
        element.text,
        style: preferredStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// utility for custom layout of teams page
class _MarkdownCustomCreators extends fmd.MarkdownElementBuilder {
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
