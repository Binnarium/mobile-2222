import 'package:flutter/material.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';

class IdeaResourcesListItem extends StatelessWidget {
  const IdeaResourcesListItem({Key? key, this.description}) : super(key: key);

  final String? description;

  @override
  Widget build(BuildContext context) {
    String descTemp;
    description == null
        ? descTemp = 'No se ha cargado una idea'.toUpperCase()
        : descTemp = description!;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),

      ///static height
      // height: 120,
      child: Wrap(
        // antes era column el wrap
        alignment: WrapAlignment.start,
        spacing: 5,

        children: [
          Markdown2222(
            data: descTemp,
          ),
        ],
      ),
    );
  }
}
