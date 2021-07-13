import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class CompeResourcesListItem extends StatelessWidget {
  final String kind;
  // final String image;
  final String description;

  const CompeResourcesListItem(
      {Key? key,
      required this.kind,
      // required this.image,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String kindIcon = this.kind.replaceAll("COMPETENCIES#", '').toLowerCase() ;
    String description ='';
    if(kindIcon == 'time_management'){
      description = "MANEJO DEL TIEMPO";
    }else if(kindIcon == 'team_work'){
      description = "TRABAJO DE EQUIPO";
    }else if(kindIcon == 'innovation_creativity'){
      description = "INNOVACIÓN Y CREATIVIDAD";
    }
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
              image: AssetImage('assets/icons/${kindIcon}_icon.png'),
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
                  this.description,
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
