import 'package:lab_movil_2222/chat/chats/models/chat-kind.enum.dart';
import 'package:lab_movil_2222/chat/chats/models/chat.model.dart';

class ChatFolderModel {
  ChatFolderModel({
    required this.kind,
  }) : chats = [];

  final List<ChatModel> chats;
  final ChatKind kind;

  String get name => kind == ChatKind.general

      ///  general
      ? 'General'
      : kind == ChatKind.group

          ///  group
          ? 'Grupo de 10'

          ///  personal
          : 'Otros Viajeros (${chats.length})';

  DateTime? get lastActivity => lastChat?.lastActivity;

  void addChat(ChatModel chat) {
    chats.add(chat);
  }

  ChatModel? get lastChat => chats.isEmpty ? null : chats.first;
  String get chatsNames => chats.isEmpty
      ? 'No tienes chats personales'
      : chats.map((c) => c.chatName).join(' - ');
}
