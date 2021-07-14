import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class LecturesListItem extends StatelessWidget {
  final String? imageURL;
  final String title;
  final String author;
  final String? editorial;
  final Timestamp year;
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
    double fontSize = 0.9;

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
                        fit: BoxFit.cover,
                        width: 80,
                        // height: 110,
                      ))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: AssetImage('assets/backgrounds/no-image.png'),
                        fit: BoxFit.fill,
                        width: 80,
                      ),
                    ),
              SizedBox(
                width: 15,
              ),

              ///Makes the column flexible to avoid the overflow
              Expanded(
                child: Wrap(
                  // antes era column el wrap
                  alignment: WrapAlignment.start,
                  spacing: 15,
                  runSpacing: 7,

                  children: [
                    Text(
                      title.toUpperCase(),
                      style: korolevFont.headline6
                          ?.apply(fontSizeFactor: fontSize),
                    ),

                    ///Seeks for editorial, if not, it's ommited
                    (editorial != null)
                        ? Text(
                            author +
                                ' | ' +
                                editorial! +
                                ' | ' +
                                year.toDate().year.toString(),
                            style: korolevFont.headline6
                                ?.apply(fontSizeFactor: fontSize - 0.2),
                          )
                        : Text(
                            author + ' | ' + year.toDate().year.toString(),
                            style: korolevFont.headline6
                                ?.apply(fontSizeFactor: fontSize - 0.2),
                          ),

                    ///Seeks for a review, if not, it's ommited
                    (review != null)
                        ? RichText(
                            text: TextSpan(
                                text: 'Reseña: ',
                                style: korolevFont.bodyText2?.apply(
                                  fontSizeFactor: fontSize,
                                ),
                                children: [
                                  TextSpan(
                                    text: review!,
                                    style: korolevFont.bodyText2?.apply(
                                      fontSizeFactor: fontSize,
                                    ),
                                  )
                                ]),
                          )
                        : Text(
                            'Reseña no disponible',
                            style: korolevFont.bodyText2,
                          ),
                    Container(
                      height: 10,
                    ),
                    Container(
                      width: size.width * 0.2,
                      height: 1,
                      color: Colors.white,
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
