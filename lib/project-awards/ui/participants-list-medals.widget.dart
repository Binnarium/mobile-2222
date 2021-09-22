import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class AssignMedalListItem extends ListTile {
  AssignMedalListItem({
    Key? key,
    required Function callback,
    required PlayerModel participant,
    required BuildContext context,
    required bool isAssigned,
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

          /// add button when callback is sended
          trailing: IconButton(
            onPressed: isAssigned ? () {} : () => callback(),
            icon: Icon(
              isAssigned ? Icons.star_rounded : Icons.card_giftcard_rounded,
              color: isAssigned ? Colors2222.yellow : Colors2222.darkGrey,
            ),
          ),
        );
}
