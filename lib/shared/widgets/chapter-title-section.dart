import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ChapterTitleSection extends StatelessWidget {
  final String title;

  ChapterTitleSection({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: ColorsApp.backgroundBottomBar,
        ),
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 30,
            ),
            Text(
              title,
              style: korolevFont.headline5,
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
