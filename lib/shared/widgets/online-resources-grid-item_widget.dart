import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';
import 'package:url_launcher/url_launcher.dart';

class OnlineResourcesGridItem extends StatelessWidget {
  final String name;
  final String kind;
  final String description;
  final Size size;
  final String redirect;
  final String id;

  final Color color;

  const OnlineResourcesGridItem({
    Key? key,
    required this.description,
    required this.size,
    required this.color,
    required this.name,
    required this.kind,
    required this.redirect,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String kindIcon = this.kind.replaceAll("RESOURCE#", '');
    double fontSize = (size.height > 600) ? 0.9 : 0.7;
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          launch(redirect);
        },
        child: Container(
          // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            // alignment: WrapAlignment.start,
            spacing: 5,
            runSpacing: 10,
            children: [
              Image(
                image: AssetImage(
                    'assets/icons/${kindIcon.toLowerCase()}_icon.png'),
                filterQuality: FilterQuality.high,
              ),
              Text(
                name,
                style: korolevFont.headline6?.apply(fontSizeFactor: fontSize),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                description,
                style: korolevFont.headline6
                    ?.apply(fontSizeFactor: fontSize - 0.2),
                overflow: TextOverflow.ellipsis,
                maxLines: 9,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
