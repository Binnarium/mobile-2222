import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as md;

@Deprecated('use the Markdown2222 instead')
typedef Markdown = Markdown2222;

class Markdown2222 extends StatelessWidget {
  final String data;

  const Markdown2222({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return md.MarkdownBody(
      data: this.data,
      styleSheet: md.MarkdownStyleSheet.fromTheme(Theme.of(context)),
    );
  }
}
