import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class GotoSupportForm extends StatelessWidget {
  const GotoSupportForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).primaryTextTheme;
    const pageURL = 'https://forms.gle/zLwptnPdMsfbMGfE6';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors2222.white,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            primary: Colors2222.red,
          ),
          onPressed: () {
            launch(pageURL);
          },
          child: Text(
            'Reporta un Problema',
            style: textTheme.button,
          ),
        ),
      ],
    );
  }
}
