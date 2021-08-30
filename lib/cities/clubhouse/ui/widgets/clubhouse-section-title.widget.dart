import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ClubhouseSectionTitle extends StatelessWidget {
  final String title;

  ClubhouseSectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors2222.black,
          padding: EdgeInsets.all(5),
          child: Text(
            title.toUpperCase(),
            style: textTheme.headline5,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
