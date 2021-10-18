import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_movil_2222/chat/chats/models/chat.model.dart';
import 'package:lab_movil_2222/chat/ui/screens/messages.screen.dart';
import 'package:lab_movil_2222/chat/ui/widgets/chat-image.widget.dart';

class PersonalChatListItem extends ListTile {
  PersonalChatListItem({
    Key? key,
    required ChatModel chat,
    required BuildContext context,
  }) : super(
          key: key,
          leading: ChatImageWidget(kind: chat.kind),
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.08,
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              /// chat name
              Expanded(
                child: Text(
                  chat.chatName,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              /// chat date
              Text(
                DateFormat('MM-dd HH:mm').format(chat.lastActivity),
                style: Theme.of(context).textTheme.button,
              ),
            ],
          ),

          /// show last message chat
          subtitle: Text(
            chat.chatContent,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          /// when pressed then navigate to chats screens
          onTap: () => Navigator.of(context).pushNamed(
            MessagesScreen.route,
            arguments: MessagesScreen(
              chatModel: chat,
            ),
          ),
        );
}
