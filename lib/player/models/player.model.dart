import 'dart:math';

import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/player/models/award.model.dart';
import 'package:lab_movil_2222/player/models/course-status.enum.dart';
import 'package:lab_movil_2222/shared/pipes/random-string.extencion.dart';

class PlayerModel {
  PlayerModel._({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.projectAwards,
    required this.contributionsAwards,
    required this.clubhouseAwards,
    required this.maratonAwards,
    required this.avatarImage,
    required this.groupId,
    required this.pubCode,
    required this.courseStatus,
    required this.proactivity,
    this.pubUserId,
  });

  factory PlayerModel.fromMap(final Map<String, dynamic> payload) {
    return PlayerModel._(
      avatarImage: (payload['avatarImage'] != null)
          ? ImageDto.fromMap(payload['avatarImage'] as Map<String, dynamic>? ??
              <String, dynamic>{})
          : null,
      uid: payload['uid'] as String,
      email: payload['email'] as String,
      pubCode: payload['pubCode'] as String,
      proactivity: payload['proactivity'] as int? ?? 0,
      pubUserId: payload['pubUserId'] as String?,
      displayName: payload['displayName'] as String? ?? '',
      groupId: payload['groupId'] as String,
      courseStatus: courseStatusFromString(payload['courseStatus'] as String?),
      clubhouseAwards:
          PlayerModel._getAwardsFromPayload(payload['clubhouseAwards']),
      contributionsAwards:
          PlayerModel._getAwardsFromPayload(payload['contributionsAwards']),
      maratonAwards:
          PlayerModel._getAwardsFromPayload(payload['marathonAwards']),
      projectAwards:
          PlayerModel._getAwardsFromPayload(payload['projectAwards']),
    );
  }

  final String uid;
  final String displayName;
  final String email;
  final String groupId;
  final int proactivity;

  final ImageDto? avatarImage;

  final List<AwardModel> projectAwards;
  final List<AwardModel> contributionsAwards;
  final List<AwardModel> clubhouseAwards;
  final List<AwardModel> maratonAwards;

  /// player pub
  final String pubCode;
  final String? pubUserId;

  /// course status
  final CourseStatus courseStatus;

  static List<AwardModel> _getAwardsFromPayload(dynamic payload) {
    return ((payload ?? <dynamic>[]) as List)
        .map((dynamic e) => AwardModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}

Map<String, dynamic> createNewPlayerMap({
  required String uid,
  required String displayName,
  required String email,
}) {
  return <String, dynamic>{
    'uid': uid,
    'displayName': displayName,
    'email': email,
    'projectAwards': <void>[],
    'contributionsAwards': <void>[],
    'clubhouseAwards': <void>[],
    'marathonAwards': <void>[],
    'courseStatus': null,
    'pubCode': Random().generateString(size: 8),
    'avatarImage': null,
    'groupId': null,
    'proactivity': 0,
    'pubUserId': null,
  };
}
