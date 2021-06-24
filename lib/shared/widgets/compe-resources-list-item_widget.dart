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
      margin: EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),

      ///static height
      // height: 120,
      child: Column(
        children: [
          ///seeks if an image url is provided, otherwise returns the no image png
          
          Image(
              image: AssetImage('assets/backgrounds/decorations/$image.png'),
              height: 60,
              alignment: Alignment.center,
            ),
            SizedBox(height: 9,),
          ///Makes the column flexible to avoid the overflow
          Expanded(
            child: Wrap(
              // antes era column el wrap
              alignment: WrapAlignment.center,
              spacing: 10,

              children: [
                Text(
                  description,
                  style: korolevFont.bodyText1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
    
  }
}
