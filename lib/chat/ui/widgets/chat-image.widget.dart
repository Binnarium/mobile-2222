import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/chats/models/chat-kind.enum.dart';

class ChatImageWidget extends Image {
  ChatImageWidget({
    required ChatKind kind,
    Key? key,
    double? size,
    Color? color,
  }) : super.asset(
          kind == ChatKind.general
              ? 'assets/images/chat/community.png'
              : kind == ChatKind.group
                  ? 'assets/images/chat/group.png'
                  : 'assets/images/chat/travelers.png',
          key: key,
          height: size,
          width: size,
          color: color,
        );
}
