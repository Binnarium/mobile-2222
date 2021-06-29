import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class LecturesListItem extends StatelessWidget {
  final String? imageURL;
  final String title;
  final String author;
  final String? editorial;
  final String year;
  final String? review;
  final Size size;

  const LecturesListItem({
    Key? key,
    this.imageURL,
    required this.title,
    required this.author,
    this.editorial,
    required this.year,
    this.review,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSize = (size.height > 600) ? 1 : 0.9;

    ///Returns an InkWell so it can be tapped
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          print('libro presionado');
        },

        ///Container of the resource
        child: new Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          width: double.infinity,
          // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),

          ///static height
          // height: 120,
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
                        // height: 200,
                      ),
                    ),
              SizedBox(
                width: 10,
              ),

              ///Makes the column flexible to avoid the overflow
              Expanded(
                child: Wrap(
                  // antes era column el wrap
                  alignment: WrapAlignment.start,
                  spacing: 10,

                  children: [
                    Text(
                      title.toUpperCase(),
                      style: korolevFont.headline6
                          ?.apply(fontSizeFactor: fontSize),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),

                    ///Seeks for editorial, if not, it's ommited
                    (editorial != null)
                        ? Text(
                            author + ' | ' + editorial! + ' | ' + year,
                            style: korolevFont.headline6
                                ?.apply(fontSizeFactor: fontSize - 0.2),
                          )
                        : Text(
                            author + ' | ' + year,
                            style: korolevFont.headline6
                                ?.apply(fontSizeFactor: fontSize - 0.2),
                          ),
                    // SizedBox(
                    //   height: 40,
                    // ),

                    ///Seeks for a review, if not, it's ommited
                    (review != null)
                        ? Text(
                            'Reseña: ' + review!,
                            style: korolevFont.bodyText2
                                ?.apply(fontSizeFactor: fontSize - 0.1),
                            textAlign: TextAlign.left,
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
      ),
    );
  }
}
