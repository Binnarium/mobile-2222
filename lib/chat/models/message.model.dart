import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';

/// base model of a chat message
abstract class MessageModel {
  final String id;
  final MessageKind messageKind;
  final AssetDto? asset;
  final String? text;
  final bool banned;
  final DateTime sended;
  final String senderId;
  final ChatParticipantModel sender;

  MessageModel({
    required this.id,
    required this.messageKind,
    this.asset,
    required this.text,
    required this.banned,
    required this.sended,
    required this.senderId,
    required this.sender,
  });
}

enum MessageKind {
  /// message only including text
  text,

  /// message that has been banned
  banned,

  /// message including an image
  image,

  /// message containing a video
  video,

  /// TODO: add collaboration and activities types
}

/// Message of type [MessageKind.video]
class VideoMessageModel extends MessageModel {
  VideoMessageModel({
    required String id,
    required String senderId,
    required DateTime sended,
    required ChatParticipantModel sender,
    required VideoDto video,
  }) : super(
          id: id,
          messageKind: MessageKind.video,
          asset: video,
          banned: false,
          sended: sended,
          text: null,
          senderId: senderId,
          sender: sender,
        );
}

/// Message of type [MessageKind.image]
class ImageMessageModel extends MessageModel {
  ImageMessageModel({
    required String id,
    required String senderId,
    required DateTime sended,
    required ChatParticipantModel sender,
    required ImageDto image,
  }) : super(
          id: id,
          messageKind: MessageKind.image,
          asset: image,
          banned: false,
          sended: sended,
          text: null,
          senderId: senderId,
          sender: sender,
        );
}

/// Message of type [MessageKind.text]
class TextMessageModel extends MessageModel {
  TextMessageModel({
    required String id,
    required String senderId,
    required String text,
    required DateTime sended,
    required ChatParticipantModel sender,
  }) : super(
          id: id,
          messageKind: MessageKind.text,
          asset: null,
          banned: false,
          sended: sended,
          text: text,
          senderId: senderId,
          sender: sender,
        );
}

/// Message of type [MessageKind.banned]
class BannedMessageModel extends MessageModel {
  BannedMessageModel({
    required String id,
    required String senderId,
    required DateTime sended,
    required ChatParticipantModel sender,
  }) : super(
          id: id,
          messageKind: MessageKind.banned,
          asset: null,
          banned: true,
          sended: sended,
          text: null,
          senderId: senderId,
          sender: sender,
        );
}
