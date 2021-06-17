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
    Size size = MediaQuery.of(context).size;
    double fontSize = (size.height > 600) ? 0.9 : 0.7;
    double width = (size.height > 600) ? 110 : 95;
    double height = (size.height > 600) ? 20 : 15;
    return Container(
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
            style: korolevFont.headline6?.apply(fontSizeFactor: fontSize),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          SizedBox(
            height: 1,
          ),
          Text(
            theme,
            style: korolevFont.headline6?.apply(fontSizeFactor: fontSize - 0.1),
            overflow: TextOverflow.ellipsis,
            maxLines: 6,
          ),
          SizedBox(
            height: 5,
          ),
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () {
                print('aniadir a agenda presionado');
              },
              child: Container(
                width: width,
                height: height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    border: Border.all(color: Colors.white)),
                child: Text(
                  agenda,
                  style: korolevFont.headline6
                      ?.apply(fontSizeFactor: fontSize - 0.3),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
