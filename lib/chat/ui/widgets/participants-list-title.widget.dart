import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ParticipantsListTitle extends ListTile {
  ParticipantsListTitle({
    Key? key,
    String title = 'Participantes',
    required num participantsCount,
    required BuildContext context,
  }) : super(
          key: key,
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.08,
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              /// chat name
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: title,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors2222.black.withOpacity(0.8),
                            ),
                      ),
                      TextSpan(
                        text: ' ($participantsCount)',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors2222.red.withOpacity(0.7),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
}
