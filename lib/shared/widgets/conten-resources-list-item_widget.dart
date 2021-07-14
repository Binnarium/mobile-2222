import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ContenResourcesListItem extends StatelessWidget {
  final String index;
  final String description;

  const ContenResourcesListItem(
      {Key? key, required this.index, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final espacio;
    final especioTexto;
    index=='1' ? espacio=5.0: espacio=0.0;
    index=='1' ? especioTexto=5.60: especioTexto=0.0;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      
      ///static height
      // height: 120,
      child: Row(
        children: [
          ///seeks if an image url is provided, otherwise returns the no image png
          SizedBox(
            width: espacio,
            
          ),

          Text(
            index.toUpperCase(),            
            style: korolevFont.headline3,
            
          ),
          SizedBox(
            width: especioTexto,
          ),

          ///Makes the column flexible to avoid the overflow
          Expanded(
            child: Wrap(
              // antes era column el wrap
              alignment: WrapAlignment.start,
              spacing: 10,

              children: [
                Text(
                  description,
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
