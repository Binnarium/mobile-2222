import 'package:flutter/cupertino.dart';
import 'package:lab_movil_2222/chat/chats/models/chat-kind.enum.dart';
import 'package:lab_movil_2222/chat/chats/models/chat.model.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';

class ChatTextDescription extends Markdown2222 {
  ChatTextDescription.informationText({
    Key? key,
    Color? color,
  }) : super(
          key: key,
          data: '''
Este chart sirve para las primeras interacciones entre docentes y grupos. 

Para hilos y conversaciones más extendidas, recomendamos el uso de **WhatsApp** y **Telegram**.
''',
          contentAlignment: WrapAlignment.center,
          textColor: color ?? Colors2222.black.withOpacity(0.6),
        );

  ChatTextDescription.generalText({
    Key? key,
    Color? color,
  }) : super(
          key: key,
          data:
              'Si tienes dudas o problemas, **desde aquí te comunicas con los gestores de la plataforma**. O también desde info@labmovil2222.utpl.edu.ec',
          contentAlignment: WrapAlignment.center,
          textColor: color ?? Colors2222.black.withOpacity(0.6),
        );

  ChatTextDescription.groupText({
    Key? key,
    Color? color,
  }) : super(
          key: key,
          data:
              'Aquí puedes iniciar la **conversación con tu grupo**, para ayudarse mutuamente en el desarrollo del viaje y sus actividades.',
          contentAlignment: WrapAlignment.center,
          textColor: color ?? Colors2222.black.withOpacity(0.6),
        );

  ChatTextDescription.personalText({
    Key? key,
    Color? color,
  }) : super(
          key: key,
          data:
              'Aquí puedes iniciar **la conversación con otros viajeros fuera de tu grupo**, para ayudarse mutuamente en el desarrollo del viaje y sus actividades.',
          contentAlignment: WrapAlignment.center,
          textColor: color ?? Colors2222.black.withOpacity(0.6),
        );

  factory ChatTextDescription.getChatText({
    required ChatModel chat,
    required Color? color,
  }) {
    ///
    if (ChatKind.general == chat.kind) {
      return ChatTextDescription.generalText(color: color);
    }

    ///
    if (ChatKind.group == chat.kind) {
      return ChatTextDescription.groupText(color: color);
    }

    ///
    if (ChatKind.personal == chat.kind) {
      return ChatTextDescription.personalText(color: color);
    }

    ///
    return ChatTextDescription.informationText(color: color);
  }
}
