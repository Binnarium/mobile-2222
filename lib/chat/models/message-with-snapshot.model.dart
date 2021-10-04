import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';

/// base model of a chat message
class MessageWithSnapshotModel {
  /// constructor
  MessageWithSnapshotModel({
    required this.message,
    required this.snapshot,
  });

  /// params
  final MessageModel message;
  final DocumentSnapshot snapshot;
}
