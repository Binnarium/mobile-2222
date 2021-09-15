import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/services/create-personal-chats.service.dart';
import 'package:lab_movil_2222/chat/services/get-chat.service.dart';
import 'package:lab_movil_2222/chat/ui/screens/messages.screen.dart';
import 'package:lab_movil_2222/chat/ui/widgets/chat-image.widget.dart';
import 'package:lab_movil_2222/chat/ui/widgets/chat-text-description.widget.dart';
import 'package:lab_movil_2222/chat/ui/widgets/participants-list-item.widget.dart';
import 'package:lab_movil_2222/chat/ui/widgets/participants-list-title.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class ChatParticipantsScreen extends StatefulWidget {
  static const route = '/chat-participants';

  final ChatModel chat;

  const ChatParticipantsScreen({
    Key? key,
    required this.chat,
  }) : super(key: key);

  @override
  _ChatParticipantsScreenState createState() => _ChatParticipantsScreenState();
}

class _ChatParticipantsScreenState extends State<ChatParticipantsScreen> {
  StreamSubscription? _createChatSub;

  CreatePersonalChatService get _createPersonalChatService =>
      Provider.of<CreatePersonalChatService>(this.context, listen: false);

  GetChatService get _getChatService =>
      Provider.of<GetChatService>(this.context, listen: false);

  @override
  void dispose() {
    this._createChatSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold2222.empty(
      backgroundColor: Colors2222.white,
      appBar: AppBar(
        backgroundColor: Colors2222.primary,
        titleSpacing: 0,
        title: Text(
          'Participantes',
          style: textTheme.subtitle1!.copyWith(
            color: Colors2222.white,
          ),
        ),
      ),
      body: ListView(
        children: [
          /// chat name
          Padding(
            padding: const EdgeInsets.only(top: 64.0),
            child: ChatImageWidget.fromChat(
              this.widget.chat,
              color: Colors2222.black,
              size: min(270, size.width * 0.4),
            ),
          ),

          ///
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: Text(
                this.widget.chat.chatName,
                style: textTheme.headline5!.copyWith(
                  color: Colors2222.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          /// about chats
          Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 44),
            child: Center(
              child: Container(
                width: min(400, size.width * 0.8),
                child: ChatTextDescription.getChatText(
                  chat: this.widget.chat,
                  color: Colors2222.black.withOpacity(0.5),
                ),
              ),
            ),
          ),

          /// participants title
          ParticipantsListTitle(
            context: context,
            participantsCount: this.widget.chat.participants.length,
          ),

          for (ChatParticipantModel participant
              in this.widget.chat.participants)
            ParticipantsListItem(
              context: context,
              participant: participant,
              createChatCallback: this._createChatSub == null
                  ? (context) => this._createChat(participant.uid)
                  : null,
            ),
        ],
      ),
    );
  }

  void _createChat(String playerId) {
    if (this._createChatSub != null) return;

    this.setState(() {
      this._createChatSub = _createPersonalChatService.create$(playerId).listen(
        (response) async {
          /// validate chat was found
          if (response.chatId == null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(ChatSnackbar.couldNotCreateChat());
            return;
          }

          /// load chat
          final ChatModel? chat =
              await _getChatService.getChatWithId(response.chatId!);
          if (chat == null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(ChatSnackbar.chatNotFound());
            return;
          }

          Navigator.pushNamed(context, MessagesScreen.route,
              arguments: MessagesScreen(chat: chat));
        },

        /// clean stream
        onDone: () {
          this.setState(() {
            this._createChatSub?.cancel();
            this._createChatSub = null;
          });
        },
      );
    });
  }
}

class ChatSnackbar extends SnackBar {
  ChatSnackbar.couldNotCreateChat({Key? key})
      : super(
          key: key,
          content: Text('Ocurrio un problema. No se pudo acceder al chat.'),
        );
  ChatSnackbar.chatNotFound({Key? key})
      : super(
          key: key,
          content: Text('No se pudo encontrar el chat.'),
        );
}
