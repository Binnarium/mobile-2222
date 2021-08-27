import 'package:flutter/material.dart';

class MedalsListItem extends ListTile {
  MedalsListItem({
    Key? key,
    required String cityName,
  }) : super(
          key: key,
          title: Text(cityName),
        );
}
