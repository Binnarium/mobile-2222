import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/chats/models/chat-folder.model.dart';
import 'package:lab_movil_2222/chat/chats/models/chat-kind.enum.dart';
import 'package:lab_movil_2222/chat/chats/models/chat.model.dart';
import 'package:lab_movil_2222/chat/chats/services/list-chats.service.dart';
import 'package:provider/provider.dart';

/// list the chats available for a player
class ListChatsFoldersService {
  ListChatsFoldersService(BuildContext context)
      : _listChatsService =
            Provider.of<ListChatsService>(context, listen: false);

  final ListChatsService _listChatsService;

  Stream<List<ChatFolderModel>> get folders$ =>
      _listChatsService.chats$.map((chats) {
        final Map<ChatKind, ChatFolderModel> folders = {
          ChatKind.general: ChatFolderModel(kind: ChatKind.general),
          ChatKind.group: ChatFolderModel(kind: ChatKind.group),
          ChatKind.personal: ChatFolderModel(kind: ChatKind.personal),
        };

        for (final ChatModel chat in chats) folders[chat.kind]!.addChat(chat);

        final items = folders.values.toList();
        items.sort((a, b) => a.lastActivity != null || b.lastActivity != null
            ? b.lastActivity!.compareTo(a.lastActivity!)
            : 0);
        return items;
      });
}
