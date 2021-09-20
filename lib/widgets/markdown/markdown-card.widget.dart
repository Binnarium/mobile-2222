import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as fmd;
import 'package:lab_movil_2222/themes/colors.dart';

import 'markdown-center-text.builder.dart';

///
///
///
class MarkdownCard extends StatelessWidget {
  const MarkdownCard({
    Key? key,
    required this.content,
  }) : super(key: key);

  final String content;

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
        data: content,
        builders: {
          'h2': MarkdownCenterTextBuilder(
              padding: const EdgeInsets.symmetric(vertical: 8)),
          'h3': MarkdownCenterTextBuilder(
              padding: const EdgeInsets.symmetric(vertical: 4)),
          'p': MarkdownCenterTextBuilder(
              padding: const EdgeInsets.symmetric(vertical: 4)),
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
