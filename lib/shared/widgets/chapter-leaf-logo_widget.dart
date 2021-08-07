import 'package:flutter/material.dart';

import 'app-logo.widget.dart';

@Deprecated('Use instead AppLogo with the city logo kind')
class ChapterLeafLogoWidget extends StatelessWidget {
  const ChapterLeafLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLogo(kind: AppImage.cityLogo);
  }
}
