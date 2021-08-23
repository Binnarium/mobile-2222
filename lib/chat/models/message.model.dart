import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';

enum MessageKind {
  /// message only including text
  text,

  /// message that has been banned
  banned,

  /// message including an image
  image,

  /// message containing a video
  video,
}

/// base model of a chat message
abstract class MessageModel {
  final String id;
  final String kind;
  final MessageKind messageKind;
  final AssetDto? asset;
  final String? text;
  final bool banned;
  final DateTime sendedDate;
  final String senderId;
  final ChatParticipantModel sender;

  MessageModel({
    required this.id,
    required this.kind,
    required this.messageKind,
    required this.text,
    required this.banned,
    required this.sendedDate,
    required this.senderId,
    required this.sender,
    this.asset,
  });

  factory MessageModel.fromMap(Map<String, dynamic> data) {
    final String kind = data['kind'];
    final String id = data['id'];
    final String senderId = data['senderId'];
    final ChatParticipantModel sender =
        ChatParticipantModel.fromMap(data['sender']);
    final DateTime sendedDate = (data['sendedDate'] as Timestamp).toDate();

    if (kind == 'MESSAGE#TEXT') {
      final String text = data['text'];
      return TextMessageModel(
        id: id,
        senderId: senderId,
        text: text,
        sendedDate: sendedDate,
        sender: sender,
        kind: kind,
      );
    }

    if (kind == 'MESSAGE#IMAGE') {
      final ImageDto image = ImageDto.fromMap(data['asset']);
      return ImageMessageModel(
        id: id,
        senderId: senderId,
        sendedDate: sendedDate,
        sender: sender,
        kind: kind,
        image: image,
      );
    }

    if (kind == 'MESSAGE#VIDEO') {
      final VideoDto video = VideoDto.fromMap(data['asset']);
      return VideoMessageModel(
        id: id,
        senderId: senderId,
        sendedDate: sendedDate,
        sender: sender,
        kind: kind,
        video: video,
      );
    }

    if (kind == 'MESSAGE#BANNED') {
      return BannedMessageModel(
        id: id,
        senderId: senderId,
        sendedDate: sendedDate,
        sender: sender,
        kind: kind,
      );
    }

    throw UnimplementedError();
  }
}

/// Message of type [MessageKind.video]
class VideoMessageModel extends MessageModel {
  VideoMessageModel({
    required String id,
    required String senderId,
    required DateTime sendedDate,
    required ChatParticipantModel sender,
    required VideoDto video,
    required String kind,
  }) : super(
          id: id,
          kind: kind,
          messageKind: MessageKind.video,
          asset: video,
          banned: false,
          sendedDate: sendedDate,
          text: null,
          senderId: senderId,
          sender: sender,
        );
}

/// Message of type [MessageKind.image]
class ImageMessageModel extends MessageModel {
  ImageMessageModel({
    required String id,
    required String kind,
    required String senderId,
    required DateTime sendedDate,
    required ChatParticipantModel sender,
    required ImageDto image,
  }) : super(
          id: id,
          kind: kind,
          messageKind: MessageKind.image,
          asset: image,
          banned: false,
          sendedDate: sendedDate,
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
    required DateTime sendedDate,
    required ChatParticipantModel sender,
    required String kind,
  }) : super(
          kind: kind,
          id: id,
          messageKind: MessageKind.text,
          asset: null,
          banned: false,
          sendedDate: sendedDate,
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
    required DateTime sendedDate,
    required ChatParticipantModel sender,
    required String kind,
  }) : super(
          kind: kind,
          id: id,
          messageKind: MessageKind.banned,
          asset: null,
          banned: true,
          sendedDate: sendedDate,
          text: null,
          senderId: senderId,
          sender: sender,
        );
}
