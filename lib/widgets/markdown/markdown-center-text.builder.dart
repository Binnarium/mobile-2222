import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as fmd;
import 'package:markdown/markdown.dart' as md;

/// utility to center markdown text
class MarkdownCenterTextBuilder extends fmd.MarkdownElementBuilder {
  MarkdownCenterTextBuilder({
    this.padding,
  });
  final EdgeInsets? padding;

  @override
  Widget? visitText(md.Text element, TextStyle? preferredStyle) {
    return Container(
      padding: padding,
      width: double.infinity,
      child: Text(
        element.text,
        style: preferredStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
