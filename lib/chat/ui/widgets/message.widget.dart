import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/video-player.widget.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/chat/services/delete-message.service.dart';
import 'package:lab_movil_2222/chat/ui/screens/detailed-image.screen.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  /// constructor
  const MessageWidget({
    Key? key,
    required this.message,
    this.longPressFunction,
  }) : super(key: key);

  /// params
  final MessageModel message;
  final Function(MessageModel)? longPressFunction;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final _MessageCard messageCard = _MessageCard.fromMessage(
        message: message, longPressFunction: longPressFunction);

    final String prefix = message.sendedByMe
        ? ''
        : message.sender.displayName.split(' ').first + ' - ';

    final List<Widget> children = [
      Flexible(flex: 1, child: Container()),
      Expanded(
        flex: 4,
        child: Align(
          alignment:
              message.sendedByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: message.sendedByMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              /// date
              Text(
                '$prefix${DateFormat('HH:mm').format(message.sendedDate)}',
                style: textTheme.caption!.copyWith(color: Colors2222.black),
              ),

              /// ard content
              messageCard,
            ],
          ),
        ),
      ),
    ];

    return Row(
      children: (message.sendedByMe) ? children : children.reversed.toList(),
    );
  }
}

/// base clase to create a card with content for the message
abstract class _MessageCard<T extends MessageModel> extends StatelessWidget {
  /// constructor
  _MessageCard({
    Key? key,
    required T message,
    this.longPressFunction,
  })  : message = message,
        padding = const EdgeInsets.all(12),
        decoration = BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: message.sendedByMe ? Colors2222.lightGrey : Colors2222.red,
        ),
        super(key: key);

  /// params
  final T message;

  final EdgeInsets padding;
  final BoxDecoration decoration;
  final Function(MessageModel)? longPressFunction;

  static _MessageCard fromMessage({
    required MessageModel message,
    required Function(MessageModel)? longPressFunction,
  }) {
    if (message.runtimeType == TextMessageModel) {
      return _TextMessageCard(
        message: message as TextMessageModel,
        longPressFunction: longPressFunction,
      );
    }

    if (message.runtimeType == ImageMessageModel) {
      return _ImageMessageCard(
        message: message as ImageMessageModel,
        longPressFunction: longPressFunction,
      );
    }

    if (message.runtimeType == VideoMessageModel) {
      return _VideoMessageCard(
        message: message as VideoMessageModel,
        longPressFunction: longPressFunction,
      );
    }
    if (message.runtimeType == DeletedMessageModel) {
      return _DeletedMessageCard(message: message as DeletedMessageModel);
    }

    return _TextMessageCard(
      message: message as TextMessageModel,
      longPressFunction: longPressFunction,
    );
  }
}

/// text message card
class _TextMessageCard extends _MessageCard<TextMessageModel> {
  _TextMessageCard({
    Key? key,
    required TextMessageModel message,
    Function(MessageModel)? longPressFunction,
  }) : super(
          key: key,
          message: message,
          longPressFunction: longPressFunction,
        );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        longPressFunction!(message);
      },
      child: Container(
        padding: padding,
        decoration: decoration,
        child: Markdown2222(
          data: message.text!,
          contentAlignment:
              message.sendedByMe ? WrapAlignment.end : WrapAlignment.start,
          color: message.sendedByMe ? Colors2222.black : Colors2222.white,
        ),
      ),
    );
  }
}

/// text message card
class _DeletedMessageCard extends _MessageCard<DeletedMessageModel> {
  _DeletedMessageCard({
    Key? key,
    required DeletedMessageModel message,
  }) : super(
          key: key,
          message: message,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: decoration,
      child: Text(
        message.text!,
        style: Theme.of(context)
            .textTheme
            .bodyText2
            ?.apply(color: Colors2222.black, fontStyle: FontStyle.italic),
      ),
    );
  }
}

/// image message card
class _ImageMessageCard extends _MessageCard<ImageMessageModel> {
  _ImageMessageCard({
    Key? key,
    required ImageMessageModel message,
    Function(MessageModel)? longPressFunction,
  }) : super(
          key: key,
          message: message,
          longPressFunction: longPressFunction,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: decoration,
      width: double.infinity,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            DetailedImageScreen.route,
            arguments: DetailedImageScreen(
              image: message.asset! as ImageDto,
            ),
          );
        },
        onLongPress: () {
          longPressFunction!(message);
        },
        child: Image.network(
          message.asset!.url,
          height: 140,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/// video message card
class _VideoMessageCard extends _MessageCard<VideoMessageModel> {
  _VideoMessageCard({
    Key? key,
    required VideoMessageModel message,
    Function(MessageModel)? longPressFunction,
  }) : super(
          key: key,
          message: message,
          longPressFunction: longPressFunction,
        );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        longPressFunction!(message);
      },
      child: Container(
        padding: padding,
        decoration: decoration,
        width: double.infinity,
        child: VideoPlayer(video: message.asset! as VideoDto),
      ),
    );
  }
}
