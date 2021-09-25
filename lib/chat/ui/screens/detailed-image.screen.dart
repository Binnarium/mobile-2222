import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

class DetailedImageScreen extends StatelessWidget {
  /// constructor
  const DetailedImageScreen({
    Key? key,
    required this.image,
  }) : super(key: key);

  /// params
  static const String route = '/detailed-image';

  final ImageDto image;

  @override
  Widget build(BuildContext context) {
    return Scaffold2222.empty(
      // backgroundColor: Colors2222.darkGrey,
      backgroundColor: Colors2222.black,
      body: SizedBox.expand(
        child: Center(
          child: Image.network(image.url),
        ),
      ),
    );
  }
}
