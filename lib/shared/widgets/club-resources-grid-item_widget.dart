import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ClubResourcesGridItem extends StatelessWidget {
  final String theme;
  final String schedule;
  final String agenda;

  const ClubResourcesGridItem(
      {Key? key,
      required this.theme,
      required this.schedule,
      required this.agenda})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('recurso club presionado');
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/icons/clubhouse_activity_icon.png'),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              schedule,
              style: korolevFont.headline6?.apply(fontSizeFactor: 0.7),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              theme,
              style: korolevFont.headline6?.apply(fontSizeFactor: 0.6),
              overflow: TextOverflow.ellipsis,
              maxLines: 6,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 95,
              height: 15,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                border: Border.all(color: Colors.white)
              ),
              child: Text(
              agenda,
              style: korolevFont.headline6?.apply(fontSizeFactor: 0.5),
              overflow: TextOverflow.ellipsis,
              maxLines: 6,
            ),
            ),
            
            
          ],
        ),
      ),
    );
  }
}
