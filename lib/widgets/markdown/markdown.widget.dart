import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as fmd;
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

@Deprecated('use the Markdown2222 instead')
typedef Markdown = Markdown2222;

class Markdown2222 extends StatelessWidget {
  final String data;

  /// color used by text content, by default is set to [Colors2222.white]
  final Color color;

  /// align content to a side
  final WrapAlignment? contentAlignment;

  // ignore: sort_constructors_first
  const Markdown2222({
    Key? key,
    required this.data,
    this.color = Colors2222.white,
    this.contentAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith(
      textTheme: KorolevFont(textColor: color),
    );

    return fmd.MarkdownBody(
      data: data,
      styleSheet: fmd.MarkdownStyleSheet.fromTheme(theme).copyWith(
        h1Align: contentAlignment,
        h2Align: contentAlignment,
        h3Align: contentAlignment,
        h4Align: contentAlignment,
        h5Align: contentAlignment,
        h6Align: contentAlignment,
        textAlign: contentAlignment,
        blockSpacing: 20,
      ),
    );
  }
}
