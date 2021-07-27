import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';
import 'package:url_launcher/url_launcher.dart';

class LecturesListItem extends StatelessWidget {
  final String? imageURL;
  final String title;
  final String author;
  final String? editorial;
  final int? year;
  final String? review;
  final String? link;
  final Size size;
  final bool hasLineBehind;

  const LecturesListItem({
    Key? key,
    this.imageURL,
    required this.title,
    required this.author,
    this.editorial,
    required this.year,
    this.review,
    required this.size,
    required this.hasLineBehind,
    this.link,
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
          if (this.link != null) {
            launch(this.link!);
          } else {
            launch("https://www.google.com/search?q=${this.title}");
          }
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
                        height: 110,
                      ))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: AssetImage('assets/backgrounds/no-image.png'),
                        fit: BoxFit.fill,
                        width: 80,
                        height: 110,
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
                                year.toString(),
                            style: korolevFont.headline6
                                ?.apply(fontSizeFactor: fontSize - 0.2),
                          )
                        : Text(
                            author + ' | ' + year.toString(),
                            style: korolevFont.headline6
                                ?.apply(fontSizeFactor: fontSize - 0.2),
                          ),

                    ///Seeks for a review, if not, it's ommited
                    (review != null)
                        ? Text(
                            review!,
                            style: korolevFont.bodyText2?.apply(
                              fontSizeFactor: fontSize,
                            ),
                          )
                        : Text(
                            'Reseña no disponible',
                            style: korolevFont.bodyText2,
                          ),
                    Container(
                      height: 10,
                    ),
                    (hasLineBehind)
                        ? Container(
                            width: size.width * 0.2,
                            height: 1,
                            color: Colors.white,
                          )
                        : Container(),
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
