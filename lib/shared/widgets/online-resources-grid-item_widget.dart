import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class OnlineResourcesGridItem extends StatelessWidget {
  final String account;
  final String type;
  final String description;

  const OnlineResourcesGridItem({
    Key? key,
    required this.account,
    required this.type,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                style: korolevFont.headline6?.apply(fontSizeFactor: 0.7),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                description,
                style: korolevFont.headline6?.apply(fontSizeFactor: 0.5),
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
