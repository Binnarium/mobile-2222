import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ListScoreboardPlayers extends ListTile {
  ListScoreboardPlayers({
    Key? key,
    required PlayerModel participant,
    required BuildContext context,
  }) : super(
          key: key,
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.08,
          ),
          title: Text(
            participant.displayName,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors2222.white,
                ),
          ),

          /// show proactivity Level
          trailing: Text(
              'Nivel de proactividad: ${participant.proactivity.toString()}'),
        );
}
