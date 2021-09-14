import 'package:flutter/material.dart';

class GamificationNumber extends StatefulWidget {
  final int number;
  final Color color;
  const GamificationNumber({
    Key? key,
    required this.number,
    required this.color,
  }) : super(key: key);

  @override
  _GamificationNumberState createState() => _GamificationNumberState();
}

class _GamificationNumberState extends State<GamificationNumber> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: this.widget.color,
      ),
      child: Text(
        this.widget.number.toString(),
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(fontWeight: FontWeight.w700, fontSize: 32),
      ),
    );
  }
}
