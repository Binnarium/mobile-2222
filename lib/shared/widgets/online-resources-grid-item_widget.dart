import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class OnlineResourcesGridItem extends StatelessWidget {
  final String account;
  final String type;
  final String description;
  final Size size;

  const OnlineResourcesGridItem({
    Key? key,
    required this.account,
    required this.type,
    required this.description,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSize = (size.height > 600) ? 0.9 : 0.7;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          print('recurso online presionado');
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage('assets/icons/${type}_icon.png'),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                account,
                style: korolevFont.headline6?.apply(fontSizeFactor: fontSize),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                description,
                style: korolevFont.headline6
                    ?.apply(fontSizeFactor: fontSize - 0.2),
                overflow: TextOverflow.ellipsis,
                maxLines: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
