import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class IdeaResourcesListItem extends StatelessWidget {
  final String? description;
  

  const IdeaResourcesListItem({Key? key, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String descTemp;
    this.description == null
        ? descTemp = 'No se ha cargado una idea'.toUpperCase()
        : descTemp = this.description!;
   
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),

      ///static height
      // height: 120,
      child: Row(
        children: [
          Container(            
            alignment: Alignment.center,
            child: Text(
              '-',
              style: korolevFont.headline3,
            ),
          ),
          SizedBox(
            width: 5,
            
          ),
          Expanded(
            child: Wrap(
              // antes era column el wrap
              alignment: WrapAlignment.start,
              spacing: 5,

              children: [
                Text(
                  descTemp,
                  style: korolevFont.bodyText1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
