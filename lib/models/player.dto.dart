import 'package:cloud_firestore/cloud_firestore.dart';

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

  const PlayerDto({
    this.medals = const [],
    this.points = 0,
    required this.uid,
    required this.displayName,
    required this.email,
  });

  PlayerDto.fromMap(final Map<String, dynamic> payload)
      : this.medals = ((payload['medals'] ?? []) as List)
            .map((e) => Medal.fromMap(e))
            .toList(),
        this.points = payload['points'] ?? 0,
        this.uid = payload['uid'],
        this.displayName = payload['displayName'] ?? "",
        this.email = payload['email'] ?? "";

  Map<String, dynamic> toMap() {
    return {
      'medals': this.medals,
      'points': this.points,
      'uid': this.uid,
      'name': this.displayName,
      'email': this.email,
    };
  }
}
