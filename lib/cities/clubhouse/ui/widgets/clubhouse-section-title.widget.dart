import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ClubhouseSectionTitle extends StatelessWidget {
  const ClubhouseSectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: min(300, size.width * 0.9),
        ),
        color: Colors2222.black,
        padding: const EdgeInsets.all(5),
        child: Text(
          title.toUpperCase(),
          style: textTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
