import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/ui/widgets/gammification-number.widget.dart';

class GamificationWidget extends StatefulWidget {
  final int numberOfMedals;
  final ImageProvider image;
  final String label;
  final Color numberColor;

  const GamificationWidget({
    Key? key,
    required this.numberOfMedals,
    required this.image,
    required this.label,
    required this.numberColor,
  }) : super(key: key);

  @override
  _GamificationWidgetState createState() => _GamificationWidgetState();
}

class _GamificationWidgetState extends State<GamificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),

      /// content of card
      child: Row(
        children: [
          /// space items to the order
          Expanded(
            child: Text(
              widget.label,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.grey.shade700),
            ),
          ),

          /// icon
          /// override image to fit a specified height
          Image(
            image: widget.image,
            fit: BoxFit.contain,
            height: 50,
            width: 50,
          ),

          /// space icon and number of medals
          SizedBox(width: 8),

          /// number of medals
          GamificationNumber(
            number: widget.numberOfMedals,
            color: widget.numberColor,
          ),
        ],
      ),
    );
  }
}
