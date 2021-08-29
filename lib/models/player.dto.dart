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
  final String name;
  final String email;
  final ImageDto avatarImage;

  PlayerDto.fromMap(final Map<String, dynamic> payload)
      : this.medals = ((payload['medals'] ?? []) as List)
            .map((e) => Medal.fromMap(e))
            .toList(),
        this.points = payload['points'] ?? 0,
        this.uid = payload['uid'],
        this.name = payload['displayName'] ?? "",
        this.email = payload['email'] ?? "",
        this.avatarImage = ImageDto.fromMap(payload['avatarImage'] ?? {});
}
