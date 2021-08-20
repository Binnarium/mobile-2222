import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/city-resources.dto.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadingItem extends StatelessWidget {
  final ReadingDto readingDto;

  const ReadingItem({
    Key? key,
    required this.readingDto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double sidePadding = MediaQuery.of(context).size.width * 0.04;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => launch(this.readingDto.validLink),

        ///Container of the resource
        child: new Container(
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: sidePadding),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// place image of book, if available, otherwise use the placeholder
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 80,
                child: AspectRatio(
                  aspectRatio: 6 / 9,
                  child: (this.readingDto.cover == null)
                      ? Image(
                          image: this.readingDto.placeholder,
                          fit: BoxFit.cover,
                        )
                      : FadeInImage(
                          placeholder: this.readingDto.placeholder,
                          image: this.readingDto.cover!.image,
                          fit: BoxFit.cover,
                        ),
                ),
              ),

              /// space items inside card
              SizedBox(width: 12),

              ///Makes the column flexible to avoid the overflow
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// reading name
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        this.readingDto.name.toUpperCase(),
                        style: textTheme.subtitle1,
                      ),
                    ),

                    /// tagline
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        this.readingDto.tagline,
                        style: textTheme.subtitle2,
                      ),
                    ),

                    /// review
                    Markdown2222(data: this.readingDto.about),
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
