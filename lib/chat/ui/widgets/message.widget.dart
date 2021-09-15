import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/video-player.widget.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/chat/ui/screens/detailed-multimedia.screen.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';

class MessageWidget extends StatelessWidget {
  final MessageModel message;
  const MessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final _MessageCard messageCard = _MessageCard.fromMessage(message: message);

    final String prefix = message.sendedByMe
        ? ''
        : message.sender.displayName.split(' ').first + ' - ';

    final List<Widget> children = [
      Flexible(child: Container(), flex: 1),
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
                '$prefix${DateFormat('HH:mm').format(this.message.sendedDate)}',
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
      children:
          (this.message.sendedByMe) ? children : children.reversed.toList(),
    );
  }
}

/// base clase to create a card with content for the message
abstract class _MessageCard<T extends MessageModel> extends StatelessWidget {
  final T message;

  final EdgeInsets padding;
  final BoxDecoration decoration;

  _MessageCard({
    Key? key,
    required T message,
  })  : this.message = message,
        this.padding = EdgeInsets.all(12),
        this.decoration = BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: message.sendedByMe ? Colors2222.lightGrey : Colors2222.red,
        ),
        super(key: key);

  static _MessageCard fromMessage({
    required MessageModel message,
  }) {
    if (message.runtimeType == TextMessageModel)
      return _TextMessageCard(message: message as TextMessageModel);

    if (message.runtimeType == ImageMessageModel)
      return _ImageMessageCard(message: message as ImageMessageModel);

    if (message.runtimeType == VideoMessageModel)
      return _VideoMessageCard(message: message as VideoMessageModel);

    return _TextMessageCard(message: message as TextMessageModel);
  }
}

/// text message card
class _TextMessageCard extends _MessageCard<TextMessageModel> {
  _TextMessageCard({
    Key? key,
    required TextMessageModel message,
  }) : super(
          key: key,
          message: message,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: this.padding,
      decoration: this.decoration,
      child: Markdown2222(
        data: this.message.text!,
        contentAlignment:
            this.message.sendedByMe ? WrapAlignment.end : WrapAlignment.start,
        color: this.message.sendedByMe ? Colors2222.black : Colors2222.white,
      ),
    );
  }
}

/// image message card
class _ImageMessageCard extends _MessageCard<ImageMessageModel> {
  _ImageMessageCard({
    Key? key,
    required ImageMessageModel message,
  }) : super(
          key: key,
          message: message,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: this.padding,
      decoration: this.decoration,
      width: double.infinity,
      child: InkWell(
        child: Image.network(
          this.message.asset!.url,
          height: 140,
          fit: BoxFit.cover,
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DetailedMultimediaScreen(message: message)));
        },
      ),
    );
  }
}

/// image message card
class _VideoMessageCard extends _MessageCard<VideoMessageModel> {
  _VideoMessageCard({
    Key? key,
    required VideoMessageModel message,
  }) : super(
          key: key,
          message: message,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: this.padding,
      decoration: this.decoration,
      width: double.infinity,
      child: VideoPlayer(video: message.asset as VideoDto),

      /// TODO: implement screen
      /// DetailedMultimediaScreen(message: message)));
    );
  }
}
