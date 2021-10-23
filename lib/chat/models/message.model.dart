import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/assets/models/asset.dto.dart';
import 'package:lab_movil_2222/assets/video/models/video.model.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';

/// base model of a chat message
abstract class MessageModel {
  /// constructor
  MessageModel({
    required this.id,
    required this.kind,
    required this.text,
    required this.banned,
    required this.sendedDate,
    required this.senderId,
    required this.sender,
    required this.sendedByMe,
    this.asset,
  });

  /// constructor
  factory MessageModel.fromMap(
    Map<String, dynamic> data, {
    required String currentUid,
  }) {
    final String kind = data['kind'] as String;
    final String id = data['id'] as String;
    final String senderId = data['senderId'] as String;
    final ChatParticipantModel sender =
        ChatParticipantModel.fromMap(data['sender'] as Map<String, dynamic>);
    final DateTime sendedDate = (data['sendedDate'] as Timestamp).toDate();
    final bool sendedByMe = currentUid == sender.uid;
    if (kind == 'MESSAGE#TEXT') {
      final String text = data['text'] as String;
      return TextMessageModel(
        id: id,
        senderId: senderId,
        text: text,
        sendedDate: sendedDate,
        sender: sender,
        sendedByMe: sendedByMe,
      );
    }

    if (kind == 'MESSAGE#IMAGE') {
      final ImageDto image =
          ImageDto.fromMap(data['asset'] as Map<String, dynamic>);
      return ImageMessageModel(
        id: id,
        senderId: senderId,
        sendedDate: sendedDate,
        sender: sender,
        image: image,
        sendedByMe: sendedByMe,
      );
    }

    if (kind == 'MESSAGE#VIDEO') {
      final VideoModel video =
          VideoModel.fromMap(data['asset'] as Map<String, dynamic>);
      return VideoMessageModel(
        id: id,
        senderId: senderId,
        sendedDate: sendedDate,
        sender: sender,
        video: video,
        sendedByMe: sendedByMe,
      );
    }

    if (kind == 'MESSAGE#BANNED') {
      return BannedMessageModel(
        id: id,
        senderId: senderId,
        sendedDate: sendedDate,
        sender: sender,
        sendedByMe: sendedByMe,
      );
    }
    if (kind == 'MESSAGE#DELETED') {
      return DeletedMessageModel(
        id: id,
        senderId: senderId,
        sendedDate: sendedDate,
        sender: sender,
        sendedByMe: sendedByMe,
      );
    }

    return UnsupportedMessageModel(
      id: id,
      kind: kind,
      senderId: senderId,
      sendedDate: sendedDate,
      sender: sender,
      sendedByMe: sendedByMe,
    );
  }

  /// params
  final String id;
  final String kind;
  final AssetDto? asset;
  final String? text;
  final bool banned;
  final DateTime sendedDate;
  final String senderId;
  final ChatParticipantModel sender;
  final bool sendedByMe;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'kind': kind,
      'asset': asset?.toMap(),
      'text': text,
      'banned': banned,
      'sendedDate': Timestamp.fromDate(sendedDate),
      'senderId': senderId,
      'sender': sender.toMap(),
    };
  }

  bool get canDelete => runtimeType != DeletedMessageModel;

  String get minifiedMessageContent;
}

/// Message of type [MessageKind.video]
class VideoMessageModel extends MessageModel {
  VideoMessageModel({
    required String id,
    required String senderId,
    required DateTime sendedDate,
    required ChatParticipantModel sender,
    required VideoModel video,
    bool sendedByMe = false,
  }) : super(
          sendedByMe: sendedByMe,
          id: id,
          kind: 'MESSAGE#VIDEO',
          asset: video,
          banned: false,
          sendedDate: sendedDate,
          text: null,
          senderId: senderId,
          sender: sender,
        );

  @override
  String get minifiedMessageContent => 'Envio un video';
}

/// Message of type [MessageKind.image]
class ImageMessageModel extends MessageModel {
  ImageMessageModel({
    required String id,
    required String senderId,
    required DateTime sendedDate,
    required ChatParticipantModel sender,
    required ImageDto image,
    bool sendedByMe = false,
  }) : super(
          sendedByMe: sendedByMe,
          id: id,
          kind: 'MESSAGE#IMAGE',
          asset: image,
          banned: false,
          sendedDate: sendedDate,
          text: null,
          senderId: senderId,
          sender: sender,
        );
  @override
  String get minifiedMessageContent => 'Envio una imagen';
}

/// Message of type [MessageKind.text]
class TextMessageModel extends MessageModel {
  TextMessageModel({
    required String id,
    required String senderId,
    required String text,
    required DateTime sendedDate,
    required ChatParticipantModel sender,
    bool sendedByMe = false,
  }) : super(
          sendedByMe: sendedByMe,
          kind: 'MESSAGE#TEXT',
          id: id,
          asset: null,
          banned: false,
          sendedDate: sendedDate,
          text: text,
          senderId: senderId,
          sender: sender,
        );

  @override
  String get minifiedMessageContent => text!;
}

/// Message of type [MessageKind.banned]
class BannedMessageModel extends MessageModel {
  BannedMessageModel({
    required String id,
    required String senderId,
    required DateTime sendedDate,
    required ChatParticipantModel sender,
    bool sendedByMe = false,
  }) : super(
          sendedByMe: sendedByMe,
          kind: 'MESSAGE#BANNED',
          id: id,
          asset: null,
          banned: true,
          sendedDate: sendedDate,
          text: null,
          senderId: senderId,
          sender: sender,
        );

  @override
  String get minifiedMessageContent => 'El mensaje ha sido prohibido';
}

/// Message of type deleted [MessageKind.deleted]
class DeletedMessageModel extends MessageModel {
  DeletedMessageModel({
    required String id,
    required String senderId,
    required DateTime sendedDate,
    required ChatParticipantModel sender,
    bool sendedByMe = false,
  }) : super(
          sendedByMe: sendedByMe,
          kind: 'MESSAGE#DELETED',
          id: id,
          asset: null,
          banned: false,
          sendedDate: sendedDate,
          text: null,
          senderId: senderId,
          sender: sender,
        );

  @override
  String get minifiedMessageContent => 'Mensaje Eliminado';
}

class UnsupportedMessageModel extends MessageModel {
  UnsupportedMessageModel({
    required String id,
    required String senderId,
    required String kind,
    required DateTime sendedDate,
    required ChatParticipantModel sender,
    bool sendedByMe = false,
  }) : super(
          sendedByMe: sendedByMe,
          kind: kind,
          id: id,
          asset: null,
          banned: false,
          sendedDate: sendedDate,
          text: null,
          senderId: senderId,
          sender: sender,
        );

  @override
  String get minifiedMessageContent =>
      'Mensaje no soportado, actualiza tu aplicación';
}
