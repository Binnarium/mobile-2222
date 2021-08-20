import 'package:flutter/material.dart';

class CompeResourcesListItem extends StatelessWidget {
  final String name;
  final String? kind;
  final Map<String, dynamic> image;
  final String? id;

  const CompeResourcesListItem({
    Key? key,
    required this.name,
    required this.image,
    this.kind,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    NetworkImage imageNe;
    String imageurl =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShMSIXzP_rbfUPmoKrBDCxlBFCITYnuzuVHg&usqp=CAU';
    image['url'] == null
        ? imageNe = new NetworkImage(imageurl)
        : imageNe = new NetworkImage(image['url']);
    return Column(
      children: [
        ///seeks if an image url is provided, otherwise returns the no image png

        Image(
          image: imageNe,
          height: 60,
          alignment: Alignment.center,
        ),
        SizedBox(
          height: 9,
        ),

        ///Makes the column flexible to avoid the overflow

        Text(
          this.name,
          style: textTheme.bodyText1,
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
