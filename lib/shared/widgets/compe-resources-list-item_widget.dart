import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class CompeResourcesListItem extends StatelessWidget {
  
  final String image;
  final String description;

  const CompeResourcesListItem(
      {Key? key,
      required this.image,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/backgrounds/decorations/$image.png'),
              height: 60,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              description,
              style: korolevFont.headline4?.apply(fontSizeFactor: 0.5),
              textAlign: TextAlign.center,
              
              maxLines: 2,
            ),
          ],
        ),
        
      );
    
  }
}
