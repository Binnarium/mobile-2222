import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ParticipantsListItem extends ListTile {
  ParticipantsListItem({
    Function(BuildContext)? createChatCallback,
    required ChatParticipantModel participant,
    required BuildContext context,
    Color color = Colors2222.black,
    Color primaryColor = Colors2222.red,
  }) : super(
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.08,
          ),
          title: Text(
            '${participant.displayName}',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: color.withOpacity(0.7),
                ),
          ),

          /// add button when callback is sended
          trailing: TextButton.icon(
            onPressed: createChatCallback == null
                ? () {}
                : () => createChatCallback(context),
            icon: Icon(Icons.messenger_outline_rounded),
            label: Text('Chat'),
            style: TextButton.styleFrom(
              primary: createChatCallback == null
                  ? color.withOpacity(0.5)
                  : primaryColor.withOpacity(0.7),
            ),
          ),
        );
}
