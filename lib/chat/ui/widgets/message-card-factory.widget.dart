import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/video-player.widget.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/chat/ui/screens/detailed-image.screen.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';

/// base clase to create a card with content for the message
abstract class MessageCardFactory<T extends MessageModel>
    extends StatelessWidget {
  /// base constructor for each factory implementation
  MessageCardFactory._({
    Key? key,
    required this.message,
    required this.deleteCallback,
  })  : padding = const EdgeInsets.all(12),
        decoration = BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: message.sendedByMe ? Colors2222.lightGrey : Colors2222.red,
        ),
        super(key: key);

  /// message to be displayed
  final T message;

  /// padding shared among all cards
  final EdgeInsets padding;

  /// decoration shared among all cards
  final BoxDecoration decoration;

  /// callback to delete a message
  final Function(MessageModel) deleteCallback;

  /// factory to create a new message card of an specific type
  static MessageCardFactory create({
    required MessageModel message,
    required Function(MessageModel) deleteCallback,
  }) {
    if (message.runtimeType == TextMessageModel) {
      return _TextMessageCard(
        message: message as TextMessageModel,
        deleteCallback: deleteCallback,
      );
    }

    if (message.runtimeType == ImageMessageModel) {
      return _ImageMessageCard(
        message: message as ImageMessageModel,
        deleteCallback: deleteCallback,
      );
    }

    if (message.runtimeType == VideoMessageModel) {
      return _VideoMessageCard(
        message: message as VideoMessageModel,
        deleteCallback: deleteCallback,
      );
    }

    if (message.runtimeType == DeletedMessageModel) {
      return _DeletedMessageCard(
        message: message as DeletedMessageModel,
        deleteCallback: deleteCallback,
      );
    }

    return _UnsupportedMessageCard(
      message: message as UnsupportedMessageModel,
      deleteCallback: deleteCallback,
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final Widget card = buildCardContent(context);

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
                /// TODO: make an extencion with dateformat
                '$prefix${DateFormat('HH:mm').format(message.sendedDate)}',
                style: textTheme.caption!.copyWith(color: Colors2222.black),
              ),

              /// ard content
              card,
            ],
          ),
        ),
      ),
    ];

    return Row(
      children: (message.sendedByMe) ? children : children.reversed.toList(),
    );
  }

  Widget buildCardContent(BuildContext context);

  void showOptionsDialog(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    showModalBottomSheet<Widget>(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// delete caller
          if (message.sendedByMe && message.canDelete)
            ListTile(
              leading: const Icon(
                Icons.delete_rounded,
                color: Colors2222.primary,
                size: 30,
              ),
              title: Text(
                'Eliminar mensaje',
                style: textTheme.bodyText2?.apply(color: Colors2222.black),
              ),
              onTap: () {
                deleteCallback(message);
                Navigator.pop(context);
              },
              tileColor: Colors2222.white,
            ),

          /// close bottom sheet
          ListTile(
            leading: const Icon(
              Icons.close_rounded,
              color: Colors2222.primary,
              size: 30,
            ),
            title: Text(
              'Cerrar',
              style: textTheme.bodyText2?.apply(color: Colors2222.black),
            ),
            onTap: () {
              Navigator.pop(context);
            },
            tileColor: Colors2222.white,
          ),
        ],
      ),
    );
  }
}

/// text message card
class _TextMessageCard extends MessageCardFactory<TextMessageModel> {
  _TextMessageCard({
    Key? key,
    required TextMessageModel message,
    required Function(MessageModel) deleteCallback,
  }) : super._(
          key: key,
          message: message,
          deleteCallback: deleteCallback,
        );

  @override
  Widget buildCardContent(BuildContext context) {
    return InkWell(
      onLongPress: () => showOptionsDialog(context),
      child: Container(
        padding: padding,
        decoration: decoration,
        child: Markdown2222(
          data: message.text!,
          contentAlignment:
              message.sendedByMe ? WrapAlignment.end : WrapAlignment.start,
          textColor: message.sendedByMe ? Colors2222.black : Colors2222.white,
        ),
      ),
    );
  }
}

class _UnsupportedMessageCard
    extends MessageCardFactory<UnsupportedMessageModel> {
  _UnsupportedMessageCard({
    Key? key,
    required UnsupportedMessageModel message,
    required Function(MessageModel) deleteCallback,
  }) : super._(
          key: key,
          message: message,
          deleteCallback: deleteCallback,
        );

  @override
  Widget buildCardContent(BuildContext context) {
    return InkWell(
      onLongPress: () => showOptionsDialog(context),
      child: Container(
        padding: padding,
        decoration: decoration,
        child: Markdown2222(
          data:
              '_Este mensaje no es soportado, actualiza tu aplicación para acceder a las últimas funcionalidades del **Lab Móvil 2222**_',
          contentAlignment:
              message.sendedByMe ? WrapAlignment.end : WrapAlignment.start,
          textColor: message.sendedByMe ? Colors2222.black : Colors2222.white,
        ),
      ),
    );
  }
}

/// text message card
class _DeletedMessageCard extends MessageCardFactory<DeletedMessageModel> {
  _DeletedMessageCard({
    Key? key,
    required DeletedMessageModel message,
    required Function(MessageModel) deleteCallback,
  }) : super._(
          key: key,
          message: message,
          deleteCallback: deleteCallback,
        );

  @override
  Widget buildCardContent(BuildContext context) {
    return InkWell(
      onLongPress: () => showOptionsDialog(context),
      child: Container(
        padding: padding,
        decoration: decoration,
        child: Text(
          'Mensaje Eliminado',
          style: Theme.of(context)
              .textTheme
              .caption
              ?.apply(color: Colors2222.darkGrey, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}

/// image message card
class _ImageMessageCard extends MessageCardFactory<ImageMessageModel> {
  _ImageMessageCard({
    Key? key,
    required ImageMessageModel message,
    required Function(MessageModel) deleteCallback,
  }) : super._(
          key: key,
          message: message,
          deleteCallback: deleteCallback,
        );

  @override
  Widget buildCardContent(BuildContext context) {
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
        onLongPress: () => showOptionsDialog(context),
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
class _VideoMessageCard extends MessageCardFactory<VideoMessageModel> {
  _VideoMessageCard({
    Key? key,
    required VideoMessageModel message,
    required Function(MessageModel) deleteCallback,
  }) : super._(
          key: key,
          message: message,
          deleteCallback: deleteCallback,
        );

  @override
  Widget buildCardContent(BuildContext context) {
    return InkWell(
      onLongPress: () => showOptionsDialog(context),
      child: Container(
        padding: padding,
        decoration: decoration,
        width: double.infinity,
        child: VideoPlayer(video: message.asset! as VideoDto),
      ),
    );
  }
}
