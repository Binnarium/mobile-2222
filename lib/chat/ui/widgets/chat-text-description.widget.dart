import 'package:flutter/cupertino.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';

class ChatTextDescription extends Markdown2222 {
  ///
  ChatTextDescription.informationText({
    Color? color,
  }) : super(
          data: """
Este chart sirve para las primeras interacciones entre docentes y grupos. 

Para hilos y conversaciones más extendidas, recomendamos el uso de **WhatsApp** y **Telegram**.
""",
          contentAlignment: WrapAlignment.center,
          color: color ?? Colors2222.black.withOpacity(0.6),
        );

  ///
  ChatTextDescription.generalText({
    Color? color,
  }) : super(
          data:
              "Si tienes dudas o problemas, **desde aquí te comunicas con los gestores de la plataforma**. O también desde info@labmovil2222.utpl.edu.ec",
          contentAlignment: WrapAlignment.center,
          color: color ?? Colors2222.black.withOpacity(0.6),
        );

  ///
  ChatTextDescription.groupText({
    Color? color,
  }) : super(
          data:
              "Aquí puedes iniciar la **conversación con tu grupo**, para ayudarse mutuamente en el desarrollo del viaje y sus actividades.",
          contentAlignment: WrapAlignment.center,
          color: color ?? Colors2222.black.withOpacity(0.6),
        );

  ///
  ChatTextDescription.personalText({
    Color? color,
  }) : super(
          data:
              "Aquí puedes iniciar **la conversación con otros viajeros fuera de tu grupo**, para ayudarse mutuamente en el desarrollo del viaje y sus actividades.",
          contentAlignment: WrapAlignment.center,
          color: color ?? Colors2222.black.withOpacity(0.6),
        );

  factory ChatTextDescription.getChatText({
    required ChatModel chat,
    required Color? color,
  }) {
    ///
    if (chat.isGeneralChat)
      return ChatTextDescription.generalText(color: color);

    ///
    if (chat.isGroupChat) return ChatTextDescription.groupText(color: color);

    ///
    if (chat.isPersonalChat)
      return ChatTextDescription.personalText(color: color);

    ///
    return ChatTextDescription.informationText(color: color);
  }
}
