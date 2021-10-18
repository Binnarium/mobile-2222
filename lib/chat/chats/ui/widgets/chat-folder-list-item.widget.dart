import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_movil_2222/chat/chats/models/chat-folder.model.dart';
import 'package:lab_movil_2222/chat/chats/models/chat-kind.enum.dart';
import 'package:lab_movil_2222/chat/chats/ui/screens/personal-chats.screen.dart';
import 'package:lab_movil_2222/chat/ui/screens/messages.screen.dart';
import 'package:lab_movil_2222/chat/ui/widgets/chat-image.widget.dart';

class ChatFolderListItem extends ListTile {
  ChatFolderListItem({
    Key? key,
    required ChatFolderModel folder,
    required BuildContext context,
  }) : super(
          key: key,
          leading: ChatImageWidget(kind: folder.kind),
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
                  folder.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              /// chat date
              if (folder.lastActivity != null)
                Text(
                  DateFormat('MM-dd HH:mm').format(folder.lastActivity!),
                  style: Theme.of(context).textTheme.button,
                ),
            ],
          ),

          /// show last message chat
          /// if the chat is the group chat, or general chat then show the last sended message
          /// otherwise, show the
          subtitle: Text(
            folder.kind == ChatKind.personal
                ? folder.chatsNames
                : folder.lastChat?.chatContent ??
                    'Aun no tienes acceso al chat',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          /// when pressed then navigate to chats screens
          onTap: () => folder.kind == ChatKind.personal
              ? Navigator.of(context).pushNamed(
                  PersonalChatsScreen.route,
                )
              : Navigator.of(context).pushNamed(
                  MessagesScreen.route,
                  arguments: MessagesScreen(
                    chat: folder.chats[0],
                  ),
                ),
        );
}
