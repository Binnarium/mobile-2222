import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ChatMessageWidget extends StatelessWidget {
  final MessageModel message;
  const ChatMessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final _TextMessageCard messageCard =
        (this.message.runtimeType == TextMessageModel)
            ? _TextMessageCard(message: this.message as TextMessageModel)
            : _TextMessageCard(message: this.message as TextMessageModel);

    final List<Widget> children = [
      Flexible(child: Container(), flex: 1),
      Flexible(
        flex: 4,
        child: Column(
          crossAxisAlignment: message.sendedByMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            /// date
            Text(
              '${DateFormat('MM-dd HH:mm').format(this.message.sendedDate)}',
              style: textTheme.caption!.copyWith(color: Colors2222.black),
            ),

            /// ard content
            messageCard,
          ],
        ),
      ),
    ];

    return Row(
      children:
          (this.message.sendedByMe) ? children : children.reversed.toList(),
    );
  }
}

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
          color: message.sendedByMe ? Colors2222.grey : Colors2222.red,
        ),
        super(key: key);
}

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
      width: double.infinity,
      child: Markdown2222(
        data: this.message.text!,
        contentAlignment:
            this.message.sendedByMe ? WrapAlignment.end : WrapAlignment.start,
        color: Colors2222.black,
      ),
    );
  }
}
