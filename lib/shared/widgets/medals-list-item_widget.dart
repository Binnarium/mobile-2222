import 'package:flutter/material.dart';

class MedalsListItem extends StatelessWidget {
  final String cityRef;
  final String? obtained;
  final String? obtainedDate;

  const MedalsListItem({
    Key? key,
    required this.cityRef,
    this.obtained,
    this.obtainedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
   
    
    return Column(
      children: [
        Text(
          this.cityRef,
          style: textTheme.bodyText1,
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
