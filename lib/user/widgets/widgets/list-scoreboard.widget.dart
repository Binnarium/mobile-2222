import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/ui/widgets/gammification-number.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/user/widgets/widgets/avatar-image.widget.dart';

class ListScoreboardPlayers extends ListTile {
  ListScoreboardPlayers({
    Key? key,
    required PlayerModel participant,
    required BuildContext context,
    required int numberProactivity,
  }) : super(
            key: key,
            contentPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.08,
              vertical: 5,
            ),
            leading: AvatarImage(image: participant.avatarImage),
            title: Text(
              participant.displayName,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors2222.white,
                  ),
            ),

            /// show proactivity Level
            trailing: GamificationNumber(
              color: Colors2222.black,
              number: numberProactivity,
            )

            /// number of medals
            );
}
