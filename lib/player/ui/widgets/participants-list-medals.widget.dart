import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/project/services/upload-maraton-medal.service.dart';

import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ParticipantsListMedalsItem extends ListTile {
  // ignore: use_key_in_widget_constructors
  
  ParticipantsListMedalsItem({
    Function(BuildContext)? createChatCallback,
    required PlayerModel participant,
    required BuildContext context,
    Color color = Colors2222.black,
    Color primaryColor = Colors2222.red,

    
  }) : super(
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.08,
          ),
          title: Text(
            participant.displayName,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: color.withOpacity(0.9),
                ),
          ),

          /// add button when callback is sended
          trailing: TextButton.icon(
            onPressed: createChatCallback == null
                ? () {}
                : () => createChatCallback(context),
            icon: const Icon(Icons.card_giftcard_rounded),
            label: const Text('Medalla'),
            style: TextButton.styleFrom(
              primary: createChatCallback == null
                  ? color.withOpacity(0.7)
                  : primaryColor.withOpacity(0.9),
            ),
          ),
        );
}
