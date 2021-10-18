import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as fmd;
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class Markdown2222 extends StatelessWidget {
  const Markdown2222({
    Key? key,
    required this.data,
    this.textColor = Colors2222.white,
    this.primaryColor = Colors2222.primary,
    this.contentAlignment,
    this.selectable = false,
  }) : super(key: key);

  /// markdown compatible content to be displayed
  final String data;

  /// color used by text content, by default is set to [Colors2222.white]
  final Color textColor;

  /// color used as a contrast color in certain parts in the markdown
  /// by default its color is set to [Colors2222.primary]
  final Color primaryColor;

  /// align content to a side
  final WrapAlignment? contentAlignment;

  /// whenever text can be selected, by default it value is set to [False]
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith(
      textTheme: KorolevFont(textColor: textColor),
    );

    return fmd.MarkdownBody(
      data: data,
      selectable: selectable,
      styleSheet: fmd.MarkdownStyleSheet.fromTheme(theme).copyWith(
        h1Align: contentAlignment,
        h2Align: contentAlignment,
        h3Align: contentAlignment,
        h4Align: contentAlignment,
        h5Align: contentAlignment,
        h6Align: contentAlignment,
        textAlign: contentAlignment,
        blockSpacing: 20,
        blockquoteDecoration: BoxDecoration(
          color: primaryColor.withOpacity(0.2),
        ),
      ),
    );
  }
}
