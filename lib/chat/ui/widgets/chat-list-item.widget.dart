import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/chat/ui/screens/messages.screen.dart';

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
            _getSubtitle(chat),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          /// when pressed then navigate to chats screens
          onTap: () => Navigator.of(context).pushNamed(
            MessagesScreen.route,
            arguments: MessagesScreen(
              chat: chat,
            ),
          ),
        );
}

String _getSubtitle(ChatModel chat) {
  if (chat.lastMessage == null) return 'No hay mensajes';
  print(chat.lastMessage!.sender.displayName);
  final String prefix = chat.lastMessage!.sendedByMe
      ? ''
      : '${chat.lastMessage!.sender.displayName.split(' ').first}: ';

  final String suffix = (chat.lastMessage.runtimeType == TextMessageModel)
      ? chat.lastMessage!.text!
      : (chat.lastMessage.runtimeType == ImageMessageModel)
          ? 'envió una imagen'
          : (chat.lastMessage.runtimeType == VideoMessageModel)
              ? 'envió un video'
              : (chat.lastMessage.runtimeType == BannedMessageModel)
                  ? '<<Mensaje ha sido eliminado>>'
                  : '...';

  return '$prefix$suffix';
}
