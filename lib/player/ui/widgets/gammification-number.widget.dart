import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class GamificationNumber extends StatefulWidget {
  final int number;
  const GamificationNumber({Key? key, required this.number}) : super(key: key);

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
        color: Colors2222.red,
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
