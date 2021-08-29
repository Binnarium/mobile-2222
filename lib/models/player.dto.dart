import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';

class Medal {
  final String cityRef;
  final bool obtained;
  final DateTime date;

  Medal.fromMap(final Map<String, dynamic> payload)
      : this.cityRef = payload['cityRef'],
        this.obtained = payload['obtained'] ?? false,
        this.date = (payload['obtainedDate'] as Timestamp).toDate();
}

class PlayerDto {
  final List<Medal> medals;
  final int points;
  final String uid;
  final String displayName;
  final String email;
  final ImageDto avatarImage;

  PlayerDto({
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
        this.medals = const [],
        this.points = 0;

  PlayerDto.fromMap(final Map<String, dynamic> payload)
      : this.medals = ((payload['medals'] ?? []) as List)
            .map((e) => Medal.fromMap(e))
            .toList(),
        this.points = payload['points'] ?? 0,
        this.uid = payload['uid'],
        this.avatarImage = ImageDto.fromMap(payload['avatarImage'] ?? {}),
        this.displayName = payload['displayName'] ?? "",
        this.email = payload['email'] ?? "";

  Map<String, dynamic> toMap() {
    return {
      'medals': this.medals,
      'points': this.points,
      'uid': this.uid,
      'displayName': this.displayName,
      'email': this.email,
    };
  }
}
