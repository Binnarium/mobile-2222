import 'package:flutter/material.dart';

/// creates a custom elevated button [color] is needed to create the button
/// with the city color, [text] is the string of the button, [icon] is the icon
/// at the head of the button, [onClicked] is the function that will be
/// executed on pressed
@Deprecated('use [ElevatedButton.icon(...)] instead')
class ButtonWidget extends StatelessWidget {
  final Color color;
  final String? text;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onClicked;

  // ignore: sort_constructors_first
  const ButtonWidget({
    Key? key,
    required this.color,
    this.text,
    this.onClicked,
    this.icon,
    this.iconColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
      onPressed: onClicked,
      style: ElevatedButton.styleFrom(
        primary: color,
      ),
      child: buildContent(textTheme),
    );
  }

  Widget buildContent(TextTheme textTheme) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: iconColor,
            )
          else
            Container(),
          const SizedBox(
            width: 12,
          ),
          Text(
            text ?? '',
            style: textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
