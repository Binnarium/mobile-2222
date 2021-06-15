import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class LecturesListItem extends StatelessWidget {
  final String? imageURL;
  final String title;
  final String author;
  final String? editorial;
  final String year;
  final String? review;

  const LecturesListItem(
      {Key? key,
      this.imageURL,
      required this.title,
      required this.author,
      this.editorial,
      required this.year,
      this.review})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///Returns an InkWell so it can be tapped
    return InkWell(
      onTap: () {
        print('libro presionado');
      },

      ///Container of the resource
      child: new Container(
        margin: EdgeInsets.all(10),
        width: double.infinity,

        ///static height
        height: 120,
        child: Row(
          children: [
            ///seeks if an image url is provided, otherwise returns the no image png
            (imageURL != null)
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage(
                      placeholder: AssetImage('assets/gifs/giphy.gif'),
                      image: NetworkImage(imageURL!),
                      fit: BoxFit.fill,
                      width: 80,
                      height: 110,
                    ))
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage('assets/backgrounds/no-image.png'),
                      fit: BoxFit.fill,
                      width: 80,
                      height: 100,
                    ),
                  ),
            SizedBox(
              width: 10,
            ),

            ///Makes the column flexible to avoid the overflow
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: korolevFont.headline6?.apply(fontSizeFactor: 0.9),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),

                  ///Seeks for editorial, if not, it's ommited
                  (editorial != null)
                      ? Text(
                          author + ' | ' + editorial! + ' | ' + year,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style:
                              korolevFont.headline6?.apply(fontSizeFactor: 0.7),
                        )
                      : Text(
                          author + ' | ' + year,
                          overflow: TextOverflow.ellipsis,
                          style:
                              korolevFont.headline6?.apply(fontSizeFactor: 0.7),
                        ),

                  ///Seeks for a review, if not, it's ommited
                  (review != null)
                      ? Expanded(
                          flex: 3,
                          child: Text(
                            'Reseña: ' + review!,
                            style: korolevFont.bodyText2
                                ?.apply(fontSizeFactor: 0.8),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            textAlign: TextAlign.left,
                          ),
                        )
                      : Text(
                          'Reseña no disponible',
                          style: korolevFont.bodyText2,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
