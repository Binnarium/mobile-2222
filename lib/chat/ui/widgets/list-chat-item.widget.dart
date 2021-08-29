import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/ui/screens/chat.screen.dart';

class ChatListItem extends ListTile {
  ChatListItem({
    required ChatModel chat,
    required BuildContext context,
  }) : super(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/icons/avatar_icon.png'),
          ),
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
                  '${chat.chatName}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              /// chat date
              Text(
                '${DateFormat('MM-dd HH:mm').format(chat.lastActivity)}',
                style: Theme.of(context).textTheme.button,
              ),
            ],
          ),

          /// show last message chat
          subtitle: Text(
            chat.chatName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          /// when pressed then navigate to chats screens
          onTap: () => Navigator.of(context).pushNamed(
            ChatScreen.route,
            arguments: ChatScreen(
              chat: chat,
            ),
          ),
        );
}
