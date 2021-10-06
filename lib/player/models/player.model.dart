import 'dart:math';

import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/player/models/award.model.dart';
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

  PlayerModel.empty({
    required this.uid,
    required this.displayName,
    required this.email,
  })  : avatarImage = ImageDto(
          height: 0,
          width: 0,
          name: 'avatar.png',
          path: '',
          url: '',
        ),
        groupId = '',
        pubCode = Random().generateString(size: 8),
        pubUserId = null,
        projectAwards = const [],
        contributionsAwards = const [],
        maratonAwards = const [],
        courseStatus = 'COURSE#NOT_STARTED',
        clubhouseAwards = const [],
        proactivity = 0;

  factory PlayerModel.fromMap(final Map<String, dynamic> payload) {
    return PlayerModel._(
      avatarImage: ImageDto.fromMap(
          payload['avatarImage'] as Map<String, dynamic>? ??
              <String, dynamic>{}),
      uid: payload['uid'] as String,
      email: payload['email'] as String,
      pubCode: payload['pubCode'] as String,
      proactivity: payload['proactivity'] as int? ?? 0,
      pubUserId: payload['pubUserId'] as String?,
      displayName: payload['displayName'] as String? ?? '',
      groupId: payload['groupId'] as String,
      courseStatus: payload['courseStatus'] as String? ?? 'COURSE#NOT_STARTED',
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

  final String courseStatus;
  final ImageDto avatarImage;

  final List<AwardModel> projectAwards;
  final List<AwardModel> contributionsAwards;
  final List<AwardModel> clubhouseAwards;
  final List<AwardModel> maratonAwards;

  /// player pub
  final String pubCode;
  final String? pubUserId;

  static List<AwardModel> _getAwardsFromPayload(dynamic payload) {
    return ((payload ?? <dynamic>[]) as List)
        .map((dynamic e) => AwardModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'projectAwards': projectAwards,
      'contributionsAwards': contributionsAwards,
      'clubhouseAwards': clubhouseAwards,
      'marathonAwards': maratonAwards,
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'courseStatus': courseStatus,
      'pubCode': pubCode,
      'avatarImage': avatarImage.toMap(),
      'groupId': groupId,
      'proactivity': proactivity,
      'pubUserId': pubUserId,
    };
  }
}
