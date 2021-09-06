import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as fmd;
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

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
