import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/player/widgets/gammification-number.widget.dart';

class GammificationKind {
  GammificationKind._();
  static const String proactivity = "proactivity";
  static const String prizes = "prizes";
  static const String clubhouse = "clubhouse";
}

class GammificationWidget extends StatefulWidget {
  final String kind;
  final int number;
  final ImageProvider? image;

  const GammificationWidget({
    Key? key,
    required this.kind,
    required this.number,
    this.image,
  }) : super(key: key);

  @override
  _GammificationWidgetState createState() => _GammificationWidgetState();
}

class _GammificationWidgetState extends State<GammificationWidget> {
  Map<String, String> title = {
    GammificationKind.proactivity: "Nivel de\nProactividad",
    GammificationKind.prizes: "Premios\nObtenidos",
    GammificationKind.clubhouse: "Medallas\nClubhouse"
  };

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        height: 88,
        alignment: Alignment.center,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title[this.widget.kind]!.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.grey.shade700),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /// checks if the widget is proactivity to change coin colors
                if (this.widget.kind == 'proactivity') ...{
                  if (this.widget.number > 0 && this.widget.number <= 10) ...[
                    CoinsImages.redCoin()
                  ],
                  if (this.widget.number > 10 && this.widget.number <= 20) ...[
                    CoinsImages.yellowCoin()
                  ],
                  if (this.widget.number > 20) ...[CoinsImages.greenCoin()],
                } else ...{
                  Image(
                    image: this.widget.image!,
                    fit: BoxFit.contain,
                    height: 50,
                  ),
                },
                SizedBox(
                  width: 8,
                ),
                GammificationNumber(
                  number: this.widget.number,
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
