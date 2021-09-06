import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as fmd;
import 'package:lab_movil_2222/widgets/markdown/markdown-center-text.builder.dart';
import 'package:markdown/markdown.dart' as md;

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
        'h2': MarkdownCenterTextBuilder(),
        'h3': MarkdownCenterTextBuilder(padding: EdgeInsets.only(top: 36)),
        'h4': MarkdownCenterTextBuilder(padding: EdgeInsets.only(top: 16)),
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
