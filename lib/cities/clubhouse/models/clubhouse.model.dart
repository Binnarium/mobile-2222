import 'package:cloud_firestore/cloud_firestore.dart';

class ClubhouseModel {
  /// constructor
  ClubhouseModel({
    required this.clubhouseUrl,
    required this.clubhouseId,
    required this.date,
    required this.name,
    required this.cityId,
    required this.uploaderId,
    required this.scraped,
    required this.id,
    required this.uploaderDisplayName,
  });

  /// constructor
  ClubhouseModel.fromMap(Map<String, dynamic> data)
      : clubhouseUrl = data['clubhouseUrl'] as String,
        uploaderDisplayName = data['uploaderDisplayName'] as String?,
        clubhouseId = data['clubhouseId'] as String,
        date = (data['date'] as Timestamp).toDate(),
        name = data['name'] as String,
        cityId = data['cityId'] as String,
        uploaderId = data['uploaderId'] as String,
        scraped = (data['scraped'] as Timestamp).toDate(),
        id = data['id'] as String;

  final String clubhouseUrl;
  final String clubhouseId;
  final DateTime date;
  final String name;
  final String cityId;
  final String uploaderId;
  final DateTime scraped;
  final String id;
  final String? uploaderDisplayName;
}
