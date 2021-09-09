import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';

class ChatImageWidget extends Image {
  ChatImageWidget._({
    required String path,
    double? size,
    Color? color,
  }) : super.asset(
          path,
          height: size,
          width: size,
          color: color,
        );

  factory ChatImageWidget.general({
    double? size,
    Color? color,
  }) =>
      ChatImageWidget._(
        path: 'assets/images/chat/community.png',
        size: size,
        color: color,
      );

  factory ChatImageWidget.group({
    double? size,
    Color? color,
  }) =>
      ChatImageWidget._(
        path: 'assets/images/chat/group.png',
        size: size,
        color: color,
      );

  factory ChatImageWidget.personal({
    double? size,
    Color? color,
  }) =>
      ChatImageWidget._(
        path: 'assets/images/chat/travelers.png',
        size: size,
        color: color,
      );

  factory ChatImageWidget.fromChat(
    ChatModel chat, {
    double? size,
    Color? color,
  }) {
    if (chat.isPersonalChat)
      return ChatImageWidget.personal(
        size: size,
        color: color,
      );
    if (chat.isGroupChat)
      return ChatImageWidget.group(
        size: size,
        color: color,
      );
    return ChatImageWidget.general(
      size: size,
      color: color,
    );
  }
}
