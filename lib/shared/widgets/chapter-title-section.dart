import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ChapterTitleSection extends StatelessWidget {
  final String title;

  ChapterTitleSection({
    Key? key,
    required String title,
  })  : title = title.toUpperCase(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double leftPadding = MediaQuery.of(context).size.width * 0.08;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors2222.black,
          padding: EdgeInsets.fromLTRB(leftPadding, 5, 5, 5),
          child: Text(
            title,
            style: textTheme.headline5,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
