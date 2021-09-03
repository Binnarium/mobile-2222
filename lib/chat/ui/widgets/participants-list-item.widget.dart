import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ParticipantsListItem extends ListTile {
  ParticipantsListItem({
    required ChatParticipantModel participant,
    required BuildContext context,
  }) : super(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/icons/avatar_icon.png'),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.08,
          ),
          title: Text(
            '${participant.displayName}',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors2222.black.withOpacity(0.7),
                ),
          ),
        );
}
