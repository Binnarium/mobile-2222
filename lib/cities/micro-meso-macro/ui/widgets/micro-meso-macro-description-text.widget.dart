import 'package:flutter/material.dart';

class MicroMesoMacroDescriptionText extends StatelessWidget {
  const MicroMesoMacroDescriptionText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: textTheme.headline4!.copyWith(
          fontWeight: FontWeight.w300,
          fontSize: 28,
        ),
        children: [
          // ignore: use_raw_strings
          for (String text in this.text!.toLowerCase().split('\\n'))
            TextSpan(
              text: '${text.toUpperCase().trim()}\n',
            ),
        ],
      ),
    );
  }
}
