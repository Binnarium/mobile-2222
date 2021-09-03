import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/ui/widgets/participants-list-item.widget.dart';
import 'package:lab_movil_2222/chat/ui/widgets/participants-list-title.widget.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

const String chatsInfo = """
Este chart sirve para las primeras interacciones entre docentes y grupos. 

Para hilos y conversaciones más extendidas, recomendamos el uso de **WhatsApp** y **Telegram**.
""";

class ChatParticipantsScreen extends StatelessWidget {
  static const route = '/chat-participants';

  final ChatModel chat;

  const ChatParticipantsScreen({
    Key? key,
    required this.chat,
  }) : super(key: key);

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
            child: Center(
              child: Text(
                this.chat.chatName,
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
                child: Markdown2222(
                  data: chatsInfo,
                  color: Colors2222.black.withOpacity(0.5),
                  contentAlignment: WrapAlignment.center,
                ),
              ),
            ),
          ),

          /// participants title
          ParticipantsListTitle(
            context: context,
            participantsCount: this.chat.participants.length,
          ),

          for (ChatParticipantModel participant in this.chat.participants)
            ParticipantsListItem(
              context: context,
              participant: participant,
            ),
        ],
      ),
    );
  }
}
