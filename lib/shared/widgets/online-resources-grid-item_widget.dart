import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class OnlineResourcesGridItem extends StatelessWidget {
  final String account;
  final String type;
  final String description;
  final Size size;
  final Color color;

  const OnlineResourcesGridItem({
    Key? key,
    required this.account,
    required this.type,
    required this.description,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSize = (size.height > 600) ? 0.9 : 0.7;
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          print('recurso online presionado');
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
                image: AssetImage('assets/icons/${type}_icon.png'),
                filterQuality: FilterQuality.high,
              ),
              Text(
                account,
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
