import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as fmd;
import 'package:markdown/markdown.dart' as md;

/// utility to center markdown text
class MarkdownCenterTextBuilder extends fmd.MarkdownElementBuilder {
  final EdgeInsets? padding;

  MarkdownCenterTextBuilder({
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
