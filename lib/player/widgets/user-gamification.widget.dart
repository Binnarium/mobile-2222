import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';

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

class GammificationNumber extends StatefulWidget {
  final int number;
  const GammificationNumber({Key? key, required this.number}) : super(key: key);

  @override
  _GammificationNumberState createState() => _GammificationNumberState();
}

class _GammificationNumberState extends State<GammificationNumber> {
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

class CoinsImages extends Image {
  CoinsImages.redCoin({Key? key})
      : super(
          image: AssetImage('assets/gamification/2222_proactivo_rojo.png'),
          fit: BoxFit.contain,
          height: 50,
        );

  CoinsImages.yellowCoin({Key? key})
      : super(
          image: AssetImage('assets/gamification/2222_proactivo_amarillo.png'),
          fit: BoxFit.contain,
          height: 50,
        );
  CoinsImages.greenCoin({Key? key})
      : super(
          image: AssetImage('assets/gamification/2222_proactivo_verde.png'),
          fit: BoxFit.contain,
          height: 50,
        );
}
