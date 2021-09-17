import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/player/models/award.model.dart';

class PlayerModel {
  final String uid;
  final String displayName;
  final String email;
  final String groupId;

  final ImageDto avatarImage;

  final List<AwardModel> projectAwards;
  final List<AwardModel> contributionsAwards;
  final List<AwardModel> clubhouseAwards;
  final List<AwardModel> hackatonAwards;

  PlayerModel._({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.projectAwards,
    required this.contributionsAwards,
    required this.clubhouseAwards,
    required this.hackatonAwards,
    required this.avatarImage,
    required this.groupId,
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
        projectAwards = const [],
        contributionsAwards = const [],
        hackatonAwards = const [],
        clubhouseAwards = const [];

  factory PlayerModel.fromMap(final Map<String, dynamic> payload) {
    return PlayerModel._(
      avatarImage: ImageDto.fromMap(
          payload['avatarImage'] as Map<String, dynamic>? ??
              <String, dynamic>{}),
      uid: payload['uid'] as String,
      email: payload['email'] as String,
      displayName: payload['displayName'] as String? ?? '',
      groupId: payload['groupId'] as String,
      clubhouseAwards:
          PlayerModel._getAwardsFromPayload(payload['clubhouseAwards']),
      contributionsAwards:
          PlayerModel._getAwardsFromPayload(payload['contributionsAwards']),
      hackatonAwards:
          PlayerModel._getAwardsFromPayload(payload['hackatonAwards']),
      projectAwards:
          PlayerModel._getAwardsFromPayload(payload['projectAwards']),
    );
  }
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
      'hackatonAwards': hackatonAwards,
      'uid': uid,
      'displayName': displayName,
      'email': email,
    };
  }
}
