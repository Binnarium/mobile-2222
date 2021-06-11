import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class CompeResourcesGridItem extends StatelessWidget {
  
  final String image;
  final String description;

  const CompeResourcesGridItem(
      {Key? key,
      required this.image,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('recurso online presionado');
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: AssetImage('assets/backgrounds/decorations/$image.png'),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              description,
              style: korolevFont.headline4?.apply(fontSizeFactor: 0.5),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 6,
            ),
          ],
        ),
      ),
    );
  }
}
