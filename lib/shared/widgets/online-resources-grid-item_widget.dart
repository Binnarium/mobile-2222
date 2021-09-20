import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/city-resources.dto.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ExternalLinkCard extends StatelessWidget {
  const ExternalLinkCard({
    Key? key,
    required this.externalLinkDto,
  }) : super(key: key);

  final ExternalLinkDto externalLinkDto;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double sidePadding = MediaQuery.of(context).size.width * 0.04;
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => launch(externalLinkDto.link),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: sidePadding, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Image(
                  image: externalLinkDto.iconImage,
                  filterQuality: FilterQuality.high,
                  width: 50,
                  height: 50,
                  color: Colors2222.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  externalLinkDto.title,
                  style: textTheme.subtitle1,
                ),
              ),
              Markdown2222(data: externalLinkDto.description)
            ],
          ),
        ),
      ),
    );
  }
}
