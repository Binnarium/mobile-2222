import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/player/models/award.model.dart';

class PlayerModel {
  final String uid;
  final String displayName;
  final String email;

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
  });

  PlayerModel.empty({
    required this.uid,
    required this.displayName,
    required this.email,
  })  : this.avatarImage = ImageDto(
          height: 0,
          width: 0,
          name: 'avatar.png',
          path: '',
          url: '',
        ),
        this.projectAwards = const [],
        this.contributionsAwards = const [],
        this.hackatonAwards = const [],
        this.clubhouseAwards = const [];

  factory PlayerModel.fromMap(final Map<String, dynamic> payload) {
    return PlayerModel._(
      avatarImage: ImageDto.fromMap(payload['avatarImage'] ?? {}),
      uid: payload['uid'],
      email: payload['email'],
      displayName: payload['displayName'] ?? "",
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
    return ((payload ?? []) as List).map((e) => AwardModel.fromMap(e)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'projectAwards': this.projectAwards,
      'contributionsAwards': this.contributionsAwards,
      'clubhouseAwards': this.clubhouseAwards,
      'hackatonAwards': this.hackatonAwards,
      'uid': this.uid,
      'displayName': this.displayName,
      'email': this.email,
    };
  }
}
