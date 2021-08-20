import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ChapterSubtitleSection extends StatelessWidget {
  final String title;

  ChapterSubtitleSection({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return UnconstrainedBox(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: Colors2222.backgroundBottomBar,
        ),
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
