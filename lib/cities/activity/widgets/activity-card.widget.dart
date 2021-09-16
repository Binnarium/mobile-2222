import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';

class ActivityCardWidget extends StatelessWidget {
  const ActivityCardWidget({
    Key? key,
    required this.content,
    required this.iconPath,
    required this.title,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final Color color;
  final String iconPath;
  final String content;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// card content
        Container(
          /// add spacing on top for icon
          margin: const EdgeInsets.only(top: 32.0),

          /// material to capture touch events
          child: Material(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(15),
            color: Colors2222.white,
            child: InkWell(
              splashColor: color.withOpacity(0.2),
              onTap: () => onTap(),

              /// card inner content
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 32.0, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// card title
                    Text(
                      title.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: color),
                      textAlign: TextAlign.center,
                    ),

                    /// card content
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Markdown2222(
                        data: content,
                        color: Colors2222.black,
                        contentAlignment: WrapAlignment.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        /// position card icon on top
        Positioned(
          left: 0,
          right: 0,
          child: Center(
            child: Image.asset(
              iconPath,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
      ],
    );
  }
}
