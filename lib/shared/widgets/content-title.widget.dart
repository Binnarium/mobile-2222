import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ContentTitleWidget extends StatelessWidget {
  const ContentTitleWidget({
    Key? key,
    required this.author,
    required this.title,
    required this.kind,
    this.textColor,
  }) : super(key: key);

  final Color? textColor;
  final String? author;
  final String? title;
  final String kind;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors2222.white,
      width: double.infinity,
      padding:
          EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                  text: (author == null)
                      ? 'No author available'
                      : author!.toUpperCase(),
                  style: textTheme.subtitle1?.apply(
                    color: Colors.black,
                  ),
                  children: [
                TextSpan(
                  text: kind.toUpperCase(),
                  style: textTheme.subtitle2?.apply(
                    color: Colors.black45,
                  ),
                )
              ])),
          const SizedBox(
            height: 10,
          ),
          Text(
            (title == null) ? 'No title Available' : title!.toUpperCase(),
            style: textTheme.headline6?.apply(
              color: textColor ?? Colors2222.red,
            ),
          ),
        ],
      ),
    );
  }
}
