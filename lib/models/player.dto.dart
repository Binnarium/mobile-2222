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

  PlayerDto.fromMap(final Map<String, dynamic> payload)
      : this.medals = ((payload['medals'] ?? []) as List)
            .map((e) => Medal.fromMap(e))
            .toList(),
        this.points = payload['points'],
        this.uid = payload['uid'];
}
