import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:transparent_image/transparent_image.dart';

/// card to display the number of medals obtained
class ObtainedMedalsCardWidget extends StatelessWidget {
  /// number of medals a player has obtained
  final int numberOfMedals;

  /// medal image
  final ImageProvider image;

  /// card label
  final String label;

  /// color used in the medals counter
  final Color numberColor;

  /// label of the action button
  final String? actionLabel;

  /// action button callback
  final VoidCallback? actionCallback;

  // ignore: sort_constructors_first
  const ObtainedMedalsCardWidget({
    Key? key,
    required this.numberOfMedals,
    required this.image,
    required this.label,
    required this.numberColor,
    this.actionCallback,
    this.actionLabel,
  })  : assert((actionCallback == null) == (actionLabel == null),
            'must provide a label and action at the same time to enable the card callback'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).primaryTextTheme;

    final double sidePadding = MediaQuery.of(context).size.width * 0.04;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),

      /// content of card
      child: Column(
        children: [
          /// main card content
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: sidePadding, vertical: 24),
            child: Row(
              children: [
                /// card label
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(color: Colors2222.darkGrey),
                  ),
                ),

                /// icon
                /// override image to fit a specified height
                FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: image,
                  fit: BoxFit.contain,
                  height: 50,
                  width: 50,
                ),

                /// space icon and number of medals
                const SizedBox(width: 8),

                /// number of medals
                GamificationNumber(
                  number: numberOfMedals,
                  color: numberColor,
                ),
              ],
            ),
          ),

          /// card callback button
          if ((actionCallback != null) && (actionLabel != null)) ...[
            Divider(
              thickness: 1,
              height: 0,
              color: Colors2222.black.withOpacity(0.5),
            ),

            /// callback button
            Material(
              type: MaterialType.transparency,
              color: Colors2222.black,
              child: InkWell(
                onTap: actionCallback,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(
                      horizontal: sidePadding, vertical: 16),
                  child: Text(
                    'Tabla de Puntuaciones',
                    style:
                        textTheme.button?.copyWith(color: Colors2222.darkGrey),
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}

class GamificationNumber extends StatelessWidget {
  final int number;
  final Color color;
  // ignore: sort_constructors_first
  const GamificationNumber({
    Key? key,
    required this.number,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Text(
        number.toString(),
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(fontWeight: FontWeight.w700, fontSize: 32),
      ),
    );
  }
}
